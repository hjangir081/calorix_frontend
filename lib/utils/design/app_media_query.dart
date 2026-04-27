import 'package:flutter/material.dart';

class AppMediaQuery {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static Size size(BuildContext context) =>
      MediaQuery.of(context).size;

  static double topPadding(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static double bottomPadding(BuildContext context) =>
      MediaQuery.of(context).padding.bottom;

  static double statusBarHeight(BuildContext context) =>
      MediaQuery.of(context).viewPadding.top;

  static double keyboardHeight(BuildContext context) =>
      MediaQuery.of(context).viewInsets.bottom;

  /// Safe usable height (excluding status + bottom nav)
  static double safeHeight(BuildContext context) =>
      height(context) -
          topPadding(context) -
          bottomPadding(context);
}