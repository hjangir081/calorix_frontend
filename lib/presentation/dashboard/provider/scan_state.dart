import 'package:camera/camera.dart';

import '../../../domain/models/response/food_scan_response_model.dart';

class ScanState {
  final CameraController? controller;
  final bool isInitialized;
  final bool isLoading;
  final String? imagePath;
  final bool hasPermission;
  final FoodScanResponseModel? response;
  final String? errorMessage;

  const ScanState({
    this.controller,
    this.isInitialized = false,
    this.isLoading = false,
    this.imagePath,
    this.hasPermission = true,
    this.response,
    this.errorMessage,
  });

  ScanState copyWith({
    CameraController? controller,
    bool? isInitialized,
    bool? isLoading,
    String? imagePath,
    bool? hasPermission,
    FoodScanResponseModel? response,
    String? errorMessage,
  }) {
    return ScanState(
      controller: controller ?? this.controller,
      isInitialized: isInitialized ?? this.isInitialized,
      isLoading: isLoading ?? this.isLoading,
      imagePath: imagePath ?? this.imagePath,
      hasPermission: hasPermission ?? this.hasPermission,
      response: response ?? this.response,
      errorMessage: errorMessage,
    );
  }
}