import 'package:flutter/material.dart';
import 'app_spacing.dart';

class AppRadius {
  static double xs(BuildContext context) =>
      4 * AppSpacing.scale(context);

  static double sm(BuildContext context) =>
      8 * AppSpacing.scale(context);

  static double md(BuildContext context) =>
      12 * AppSpacing.scale(context);

  static double lg(BuildContext context) =>
      16 * AppSpacing.scale(context);

  static double xl(BuildContext context) =>
      24 * AppSpacing.scale(context);

  static double full(BuildContext context) =>
      100 * AppSpacing.scale(context); // for pills / circles
}