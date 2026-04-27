import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/utils/constants/app_images.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_radius.dart';
import 'package:calorix_app/utils/design/app_spacing.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final bool enabled;
  final String? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? maxLength;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final String? initialValue;

  const AppTextField({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.focusNode,
    this.textInputAction,
    this.initialValue,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.isPassword;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          initialValue: widget.initialValue,
          controller: widget.controller,
          cursorColor: AppColors.black,
          keyboardType: widget.keyboardType,
          obscureText: isPassword ? _obscureText : false,
          enabled: widget.enabled,
          validator: widget.validator,
          onChanged: widget.onChanged,
          style: AppQuicksandText.bodyLarge(
            context,
          ).copyWith(fontWeight: FontWeight.w500),
          onFieldSubmitted: widget.onSubmitted,
          inputFormatters: widget.inputFormatters,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            errorText: widget.errorText,
            errorStyle: const TextStyle(height: 0, color: Colors.red),
            hintText: widget.hint,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(12), // controls spacing
                    child: Image.asset(
                      widget.prefixIcon!,
                      width: AppMediaQuery.width(context)*.02,
                      height: AppMediaQuery.height(context)*.02,
                      fit: BoxFit.contain,
                    ),
                  )
                : null,
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg(context)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg(context)),
              borderSide: BorderSide(color: AppColors.gray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg(context)),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg(context)),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.sm(context),
              vertical: AppSpacing.md(context),
            ),
          ),
        ),
      ],
    );
  }
}
