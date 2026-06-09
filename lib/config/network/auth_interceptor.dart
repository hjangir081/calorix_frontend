import 'dart:async';
import 'package:dio/dio.dart';

import '../../domain/repositories/token_storage.dart';
import '../../utils/constants/api_environment.dart';
import '../di/injector.dart';
import '../router/app_router.dart';
import '../router/app_router.gr.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;
  AuthInterceptor({required this.dio, required this.tokenStorage});
  bool _isRefreshing = false;
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }
    print("========== 401 DETECTED ==========");
    print("PATH => ${err.requestOptions.path}");
    if (_isRefreshing) {
      return handler.next(err);
    }
    _isRefreshing = true;
    try {
      final refreshToken = await tokenStorage.getRefreshToken();
      print("REFRESH TOKEN => $refreshToken");
      if (refreshToken == null || refreshToken.isEmpty) {
        await _logout();
        return handler.reject(err);
      }
      final refreshUrl =
          ApiEnvironment.baseUrl +
          ApiEnvironment.apiPrefix +
          ApiEnvironment.refreshToken;
      print("REFRESH URL => $refreshUrl");
      final refreshResponse = await dio.post(
        refreshUrl,
        data: {"refreshToken": refreshToken},
        options: Options(headers: {"Content-Type": "application/json"}),
      );
      print("REFRESH RESPONSE => ${refreshResponse.data}");
      final accessToken = refreshResponse.data['Result']['accessToken'];
      final newRefreshToken = refreshResponse.data['Result']['refreshToken'];
      await tokenStorage.saveTokens(accessToken, newRefreshToken);
      print("TOKEN REFRESH SUCCESS");
      final requestOptions = err.requestOptions;
      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
      final response = await dio.fetch(requestOptions);
      return handler.resolve(response);
    } on DioException catch (e) {
      print("========== REFRESH FAILED ==========");
      print("STATUS => ${e.response?.statusCode}");
      print("DATA => ${e.response?.data}");
      print("REQUEST => ${e.requestOptions.data}");

      await _logout();

      return handler.reject(err);
    } catch (e, stackTrace) {
      print("========== REFRESH EXCEPTION ==========");
      print(e);
      print(stackTrace);

      await _logout();

      return handler.reject(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<void> _logout() async {
    await tokenStorage.clear();

    getIt<AppRouter>().replaceAll([LoginRoute()]);
  }
}

class _PendingRequest {
  final RequestOptions requestOptions;
  final Completer<Response> completer;

  _PendingRequest(this.requestOptions, this.completer);
}
