import 'package:flutter/material.dart';

import '../../../utils/design/app_spacing.dart';

class AppGaps {
  static SizedBox h4(BuildContext context) =>
      SizedBox(height: AppSpacing.xs(context));

  static SizedBox h8(BuildContext context) =>
      SizedBox(height: AppSpacing.sm(context));

  static SizedBox h16(BuildContext context) =>
      SizedBox(height: AppSpacing.md(context));

  static SizedBox h24(BuildContext context) =>
      SizedBox(height: AppSpacing.lg(context));

  static SizedBox h32(BuildContext context) =>
      SizedBox(height: AppSpacing.xl(context));

  static SizedBox w16(BuildContext context) =>
      SizedBox(width: AppSpacing.md(context));

  // dynamic
  static SizedBox h(BuildContext context, double value) =>
      SizedBox(height: value * AppSpacing.scale(context));

  static SizedBox w(BuildContext context, double value) =>
      SizedBox(width: value * AppSpacing.scale(context));
}