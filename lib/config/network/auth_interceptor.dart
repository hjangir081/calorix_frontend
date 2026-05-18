import 'dart:async';
import 'package:calorix_app/utils/constants/api_environment.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/token_storage.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;
  bool _isRefreshing = false;
  final List<_PendingRequest> _pendingRequests = [];
  AuthInterceptor({
    required this.dio,
    required this.tokenStorage,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await tokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {

    if (err.response?.statusCode == 401) {
      final requestOptions = err.requestOptions;

      if (requestOptions.data
      is FormData) {

        final imagePath =
        requestOptions
            .extra['imagePath'];

        final file =
        await MultipartFile
            .fromFile(
          imagePath,
          filename:
          imagePath
              .split('/')
              .last,
        );

        requestOptions.data =
            FormData.fromMap({
              'image': file,
            });
      }

      if (_isRefreshing) {
        // Wait until refresh finishes
        final completer = Completer<Response>();
        _pendingRequests.add(
          _PendingRequest(requestOptions, completer),
        );
        return handler.resolve(await completer.future);
      }
      _isRefreshing = true;
      try {

        final refreshToken =
        await tokenStorage
            .getRefreshToken();

        final refreshDio = Dio(
          BaseOptions(
            baseUrl:
            '${ApiEnvironment.baseUrl}${ApiEnvironment.apiPrefix}',
          ),
        );

        final response =
        await refreshDio.post(
          ApiEnvironment.refreshToken,
          data: {
            "refreshToken":
            refreshToken,
          },
        );

        final result =
        response.data['Result'];

        final newAccessToken =
        result['accessToken'];

        final newRefreshToken =
            result['refreshToken']
                ?? refreshToken;

        await tokenStorage.saveTokens(
          newAccessToken,
          newRefreshToken,
        );

        _isRefreshing = false;

        requestOptions.headers[
        'Authorization'
        ] = 'Bearer $newAccessToken';

        final retryResponse =
        await dio.fetch(requestOptions);

        for (final pending
        in _pendingRequests) {

          pending.requestOptions.headers[
          'Authorization'
          ] = 'Bearer $newAccessToken';

          final res = await dio.fetch(
            pending.requestOptions,
          );

          pending.completer.complete(res);
        }

        _pendingRequests.clear();

        return handler.resolve(
          retryResponse,
        );

      } catch (e, s) {

        print('REFRESH ERROR =====');
        print(e);
        print(s);

        _isRefreshing = false;

        await tokenStorage.clear();

        for (final pending
        in _pendingRequests) {

          pending.completer.completeError(e);
        }

        _pendingRequests.clear();

        return handler.next(err);
      }
    }
    handler.next(err);
  }
}

class _PendingRequest {
  final RequestOptions requestOptions;
  final Completer<Response> completer;

  _PendingRequest(this.requestOptions, this.completer);
}