import 'package:flutter/material.dart';
import 'app_responsive.dart';

class AppQuicksandText {
  static TextStyle _base(
      BuildContext context,
      double size, {
        AppFontWeight weight = AppFontWeight.regular,
        Color? color,
        String? fontFamily,
      }) {
    return TextStyle(
      fontSize: size * AppResponsive.scale(context),
      fontWeight: getFontWeight(weight),
      color: color ?? Colors.black,
      fontFamily: fontFamily,
    );
  }

  static TextStyle caption(BuildContext context,
      {AppFontWeight weight = AppFontWeight.regular, Color? color}) =>
      _base(context, AppTypography.caption,
          weight: weight, color: color, fontFamily: 'Quicksand');

  static TextStyle body(BuildContext context,
      {AppFontWeight weight = AppFontWeight.regular, Color? color}) =>
      _base(context, AppTypography.body,
          weight: weight, color: color, fontFamily: 'Quicksand');

  static TextStyle bodyLarge(BuildContext context,
      {AppFontWeight weight = AppFontWeight.regular, Color? color}) =>
      _base(context, AppTypography.bodyLarge,
          weight: weight, color: color, fontFamily: 'Quicksand');

  static TextStyle title(BuildContext context,
      {AppFontWeight weight = AppFontWeight.semiBold, Color? color}) =>
      _base(context, AppTypography.title,
          weight: weight, color: color, fontFamily: 'Quicksand');

  static TextStyle heading(BuildContext context,
      {AppFontWeight weight = AppFontWeight.bold, Color? color}) =>
      _base(context, AppTypography.heading,
          weight: weight, color: color, fontFamily: 'Quicksand');

  static TextStyle display(BuildContext context,
      {AppFontWeight weight = AppFontWeight.bold, Color? color}) =>
      _base(context, AppTypography.display,
          weight: weight, color: color, fontFamily: 'Quicksand');
}




/* KURALE FONT */
class AppKuraleText {
  static TextStyle _base(
      BuildContext context,
      double size, {
        AppFontWeight weight = AppFontWeight.regular,
        Color? color,
        String? fontFamily,
      }) {
    return TextStyle(
      fontSize: size * AppResponsive.scale(context),
      fontWeight: getFontWeight(weight),
      color: color ?? Colors.black,
      fontFamily: fontFamily,
    );
  }

  static TextStyle caption(BuildContext context,
      {AppFontWeight weight = AppFontWeight.regular, Color? color}) =>
      _base(context, AppTypography.caption,
          weight: weight, color: color, fontFamily: 'Kurale');

  static TextStyle body(BuildContext context,
      {AppFontWeight weight = AppFontWeight.regular, Color? color}) =>
      _base(context, AppTypography.body,
          weight: weight, color: color, fontFamily: 'Kurale');

  static TextStyle bodyLarge(BuildContext context,
      {AppFontWeight weight = AppFontWeight.regular, Color? color}) =>
      _base(context, AppTypography.bodyLarge,
          weight: weight, color: color, fontFamily: 'Kurale');

  static TextStyle title(BuildContext context,
      {AppFontWeight weight = AppFontWeight.semiBold, Color? color}) =>
      _base(context, AppTypography.title,
          weight: weight, color: color, fontFamily: 'Kurale');

  static TextStyle heading(BuildContext context,
      {AppFontWeight weight = AppFontWeight.bold, Color? color}) =>
      _base(context, AppTypography.heading,
          weight: weight, color: color, fontFamily: 'Kurale');

  static TextStyle display(BuildContext context,
      {AppFontWeight weight = AppFontWeight.bold, Color? color}) =>
      _base(context, AppTypography.display,
          weight: weight, color: color, fontFamily: 'Kurale');
}

enum AppFontWeight {
  regular,
  medium,
  semiBold,
  bold,
}

FontWeight getFontWeight(AppFontWeight weight) {
  switch (weight) {
    case AppFontWeight.regular:
      return FontWeight.w400;
    case AppFontWeight.medium:
      return FontWeight.w500;
    case AppFontWeight.semiBold:
      return FontWeight.w600;
    case AppFontWeight.bold:
      return FontWeight.w700;
  }
}

class AppTypography {
  static const double caption = 12;
  static const double body = 14;
  static const double bodyLarge = 16;
  static const double title = 18;
  static const double heading = 22;
  static const double display = 26;
}