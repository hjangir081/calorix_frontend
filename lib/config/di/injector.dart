import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../data/datasource/local/token_storage_impl.dart';
import '../../data/datasource/remote/api_service.dart';
import '../../data/repositories/api_repository_impl.dart';
import '../../domain/repositories/api_repository.dart';
import '../../domain/repositories/token_storage.dart';
import '../router/app_router.dart';

final getIt = GetIt.instance;

Future<void> initializeApp() async {
  final dio = Dio();
  final appRouter = AppRouter();

  dio.interceptors.add(PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    compact: false,
    maxWidth: 120,
  ));

  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<TokenStorage>(
        () => TokenStorageImpl(getIt<FlutterSecureStorage>()),
  );

  // ✅ ApiService (NOW Dio exists)
  /*getIt.registerSingleton<ApiService>(
    ApiService(getIt<Dio>()),
  );*/

  // ✅ Repository
 /* getIt.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(getIt<ApiService>()),
  );*/

  getIt.registerLazySingleton<AppRouter>(() => appRouter);
}
