import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

import '../../config/di/injector.dart';
import '../../data/datasource/remote/api_service.dart';
import '../../domain/repositories/api_repository.dart';

final dioProvider = Provider<Dio>((ref) {
  return getIt<Dio>();
});
/*
final apiServiceProvider = Provider<ApiService>((ref) {
  return getIt<ApiService>();
});*/

final apiRepositoryProvider = Provider<ApiRepository>((ref) {
  return getIt<ApiRepository>();
});