import 'package:flutter/material.dart';

class AppSpacing {
  static double scale(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width < 360) return 0.85;
    if (width < 600) return 1.0;
    if (width < 900) return 1.2;
    return 1.4;
  }

  static double xs(BuildContext context) => 4 * scale(context);
  static double sm(BuildContext context) => 8 * scale(context);
  static double sml(BuildContext context) => 12 * scale(context);
  static double md(BuildContext context) => 16 * scale(context);
  static double lg(BuildContext context) => 24 * scale(context);
  static double xl(BuildContext context) => 32 * scale(context);

  static double screenHorizontal(BuildContext context) =>
      16 * scale(context);
}