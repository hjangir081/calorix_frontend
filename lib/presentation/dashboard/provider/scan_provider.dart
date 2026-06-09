import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:path_provider/path_provider.dart';
import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';
import '../../../utils/services/permission_service.dart';
import 'scan_state.dart';

final scanProvider =
StateNotifierProvider<ScanNotifier, ScanState>(
      (ref) => ScanNotifier(),
);

class ScanNotifier extends StateNotifier<ScanState> {
  ScanNotifier() : super(const ScanState());

  final _repo = getIt<ApiRepository>();
  final _tokenStorage = getIt<TokenStorage>();


  Future<void> initCamera() async {
    try {
      // 🔥 1. Ask permission
      final granted = await PermissionService.requestCamera();

      if (!granted) {
        state = state.copyWith(hasPermission: false);
        return;
      }

      // 🔥 2. Get cameras
      final cameras = await availableCameras();

      // 🔥 3. Simulator case (no camera)
      if (cameras.isEmpty) {
        state = state.copyWith(
          hasPermission: true,
          isInitialized: false,
          controller: null,
        );
        return;
      }

      // 🔥 4. Init controller
      final controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller.initialize();

      state = state.copyWith(
        controller: controller,
        isInitialized: true,
        hasPermission: true,
      );

    } catch (e) {
      state = state.copyWith(
        isInitialized: false,
        controller: null,
      );
    }
  }

  Future<String> assetToFilePath(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final file = File('${(await getTemporaryDirectory()).path}/dal.jpeg');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file.path;
  }

  Future<void> captureImageAndScan() async {
    try {
      state = state.copyWith(isLoading: true);

      String imagePath;

      if (!state.isInitialized || state.controller == null) {
        imagePath = await assetToFilePath('assets/images/dal.jpeg');
      } else {
        final image = await state.controller!.takePicture();
        imagePath = image.path;
      }

      final token = await _tokenStorage.getAccessToken();

      final result = await _repo.foodScan(
        token: 'Bearer $token',
        image: imagePath,
      );

      if (result is DataSuccess) {
        state = state.copyWith(
          isLoading: false,
          response: result.data,
          errorMessage: null,
        );
      } else if (result is DataFailed) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: result.exception?.response?.data['message'] ?? "Something went wrong",
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}