import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../data/datasource/local/token_storage_impl.dart';
import '../../data/datasource/remote/api_service.dart';
import '../../data/repositories/api_repository_impl.dart';
import '../../domain/repositories/api_repository.dart';
import '../../domain/repositories/token_storage.dart';
import '../network/auth_interceptor.dart';
import '../router/app_router.dart';

final getIt = GetIt.instance;

Future<void> initializeApp() async {
  final dio = Dio();
  final appRouter = AppRouter();

  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<TokenStorage>(
    () => TokenStorageImpl(getIt<FlutterSecureStorage>()),
  );

  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      compact: false,
      maxWidth: 120,
    ),
  );

  dio.interceptors.add(
    AuthInterceptor(dio: dio, tokenStorage: getIt<TokenStorage>()),
  );

  getIt.registerSingleton<ApiService>(ApiService(getIt<Dio>()));

  getIt.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(getIt<ApiService>()),
  );

  getIt.registerLazySingleton<AppRouter>(() => appRouter);
}
