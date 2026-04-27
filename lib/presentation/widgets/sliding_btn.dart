import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:calorix_app/utils/services/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/slide_btn_provider.dart';

class SlidingButton extends ConsumerWidget {
  final String title;
  final String? Function(String?)? snackBarMessage;
  final bool Function() onSlideComplete;
  final TextEditingController? inputController;

  const SlidingButton({
    super.key,
    required this.title,
    required this.onSlideComplete,
    this.inputController,
    this.snackBarMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(slidingProvider);
    final controller = ref.read(slidingProvider.notifier);

    const double knobSize = 50;
    const double horizontalPadding = 36;
    final double containerWidth = MediaQuery.of(context).size.width;
    final double maxDrag = containerWidth - knobSize - horizontalPadding;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        controller.updateDrag(details.delta.dx, maxDrag);
      },
      onHorizontalDragEnd: (_) {
        if (inputController != null && snackBarMessage != null) {
          final error = snackBarMessage!(inputController!.text);
          if (error != null) {
            AppTopSnackbar.show(context, error, type: SnackbarType.error);
            controller.reset();
            return;
          }
        }

        if (state.dragPosition >= maxDrag * 0.85) {
          final success = onSlideComplete();
          if (success) {
            controller.animateToEnd(maxDrag);
            // Future.delayed(const Duration(milliseconds: 800), () {
            //   controller.reset();
            // });
            controller.reset();
          } else {
            controller.reset();
          }
        } else {
          controller.reset();
        }
      },
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFCDE26D),
              Color(0xFFB5CC5A),
            ],
          ),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Center(
              child: state.completed ? Icon(Icons.check, color: AppColors.white, size: 38,) : Text(
                 title,
                style: AppQuicksandText.body(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: state.completed ? 400 : 200),
              curve: Curves.easeOut,
              left: state.dragPosition,
              child: Container(
                height: knobSize,
                width: knobSize,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_forward, color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

