import 'dart:async';
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
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
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
        final refreshToken = await tokenStorage.getRefreshToken();

        final response = await dio.post(
          '/auth/refresh',
          data: {"refresh_token": refreshToken},
        );

        final newAccessToken = response.data['access_token'];
        final newRefreshToken = response.data['refresh_token'];

        await tokenStorage.saveTokens(
            newAccessToken, newRefreshToken);

        _isRefreshing = false;

        // Retry original failed request
        requestOptions.headers['Authorization'] =
        'Bearer $newAccessToken';

        final retryResponse = await dio.fetch(requestOptions);

        // Retry all pending requests
        for (final pending in _pendingRequests) {
          pending.requestOptions.headers['Authorization'] =
          'Bearer $newAccessToken';

          final res = await dio.fetch(pending.requestOptions);
          pending.completer.complete(res);
        }

        _pendingRequests.clear();

        return handler.resolve(retryResponse);
      } catch (e) {
        _isRefreshing = false;
        await tokenStorage.clear();

        for (final pending in _pendingRequests) {
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