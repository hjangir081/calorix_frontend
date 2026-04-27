import 'package:flutter/material.dart';

import '../../../utils/design/app_spacing.dart';

class AppPadding extends StatelessWidget {
  final Widget child;
  final double? horizontal;
  final double? vertical;

  const AppPadding({
    super.key,
    required this.child,
    this.horizontal,
    this.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:AppSpacing.md(context)
      ),
      child: child,
    );
  }
}