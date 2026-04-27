import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/otp_provider.dart';

class OtpInputField extends ConsumerWidget {
  final Function(String)? onChanged;
  final Function(String)? onCompleted;

  const OtpInputField({
    super.key,
    this.onChanged,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpNotifier = ref.read(otpNotifierProvider.notifier);
    final scheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(OtpNotifier.length, (index) {
        final controller = otpNotifier.controllers[index];
        final focusNode = otpNotifier.focusNodes[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AnimatedBuilder(
            animation: Listenable.merge([controller, focusNode]),
            builder: (context, _) {
              final isFocused = focusNode.hasFocus;
              final isFilled = controller.text.isNotEmpty;

              BoxDecoration decoration;
              if (isFocused) {
                decoration = BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                );
              } else if (isFilled) {
                decoration = BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(0.6),
                    width: 1.5,
                  ),
                );
              } else {
                decoration = BoxDecoration(
                  color: scheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: scheme.outline.withOpacity(0.4),
                    width: 1.5,
                  ),
                );
              }

              return Container(
                width: AppMediaQuery.width(context)*.13,
                height: AppMediaQuery.height(context)*.06,
                alignment: Alignment.center,
                decoration: decoration,
                child: KeyboardListener(
                  focusNode: FocusNode(skipTraversal: true),
                  onKeyEvent: (event) =>
                      otpNotifier.onBackspace(index, event, onChanged),
                  child: TextField(
                    cursorColor: AppColors.black,
                    controller: controller,
                    focusNode: focusNode,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    onChanged: (val) {
                      otpNotifier.onChanged(
                        index,
                        val,
                        onChanged,
                        onCompleted,
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}