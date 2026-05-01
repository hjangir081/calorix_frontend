import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/router/app_router.gr.dart';
import '../provider/scan_provider.dart';

@RoutePage()
class ScanFoodPage extends ConsumerWidget {
  const ScanFoodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scanProvider);
    final notifier = ref.read(scanProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!state.isInitialized && state.controller == null && state.hasPermission) {
        notifier.initCamera();
      }
    });

    ref.listen(scanProvider, (prev, next) {
      if (prev?.isLoading == true && next.isLoading == false) {

        if (next.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(next.errorMessage!)),
          );
        }

        if (next.response != null && prev?.response != next.response) {
          context.router.push(
            FoodNutrientsRoute(
              data: next.response!,
            ),
          );
        }
      }
    });

    if (!state.hasPermission) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () => notifier.initCamera(),
            child: const Text("Grant Camera Permission"),
          ),
        ),
      );
    }

    /*if (state.controller == null && !state.isInitialized) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text("Camera not available on simulator"),
        ),
      );
    }*/

    /*if (!state.isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }*/
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 📷 Camera
          Positioned.fill(
            child: state.controller != null
                ? CameraPreview(state.controller!)
                : Container(
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Simulator mode",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          const ScannerOverlay(),

          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => notifier.captureImageAndScan(),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: const Icon(Icons.camera, color: Colors.white),
                ),
              ),
            ),
          ),
          if (state.isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
class ScannerOverlay extends StatelessWidget {
  const ScannerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.infinite,
      painter: ScannerPainter(),
    );
  }
}

class ScannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.6);

    final clearPaint = Paint()
      ..blendMode = BlendMode.clear;

    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: 250,
      height: 250,
    );

    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(20));

    // Draw dark overlay
    canvas.drawRect(Offset.zero & size, overlayPaint);

    // Cut transparent hole
    canvas.drawRRect(rRect, clearPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}