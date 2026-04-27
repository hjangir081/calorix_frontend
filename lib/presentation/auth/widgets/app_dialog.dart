import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../utils/design/app_radius.dart';
import '../../../utils/design/app_responsive.dart';
import '../../../utils/design/app_spacing.dart';
import '../../../utils/design/app_text.dart';

class AppDialog {
  static void show(
      BuildContext context, {
        Widget? icon,
        String? title,
        String? description,
        bool showClose = true,
        VoidCallback? onClose,
      }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dialog",
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, _, __) {
        return _DialogContent(
          icon: icon,
          title: title,
          description: description,
          showClose: showClose,
          onClose: onClose,
        );
      },
      transitionBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

class _DialogContent extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final String? description;
  final bool showClose;
  final VoidCallback? onClose;

  const _DialogContent({
    this.icon,
    this.title,
    this.description,
    required this.showClose,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 6,
            sigmaY: 6,
          ),
          child: Container(
            color: Colors.black.withOpacity(0.2),
          ),
        ),

        /*Dialog*/
        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg(context),
              ),
              padding: EdgeInsets.all(
                AppSpacing.lg(context),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.lg(context))
              ),
              child: Stack(
                children: [
                  /*Content*/
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        icon!,
                        SizedBox(height: AppSpacing.md(context)),
                      ],

                      if (title != null) ...[
                        Text(
                          title!,
                          style: AppQuicksandText.title(
                            context,
                            weight: AppFontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: AppSpacing.sm(context)),
                      ],

                      if (description != null) ...[
                        Text(
                          description!,
                          style: AppQuicksandText.body(context),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                  if (showClose)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          onClose?.call();
                        },
                        child: Icon(
                          Icons.close,
                          size: 20.r(context),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}