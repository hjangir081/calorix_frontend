import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';

enum AppButtonType {
  primary,
  secondary,
  outline,
  text,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool isDisabled;
  final bool fullWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true,
    this.prefixIcon,
    this.suffixIcon,
    this.height,
    this.borderRadius = 12,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisabled || isLoading;
    BorderSide? border;

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: height ?? AppMediaQuery.height(context)*.055,
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.white,
          textStyle: AppQuicksandText.bodyLarge(context).copyWith(fontWeight: FontWeight.bold),
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: border ?? BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              const SizedBox(width: 8),
            ],
            Text(text),
            if (suffixIcon != null) ...[
              const SizedBox(width: 8),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}