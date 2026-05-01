// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:calorix_app/domain/models/response/food_scan_response_model.dart'
    as _i16;
import 'package:calorix_app/presentation/auth/page/create_profile.dart' as _i1;
import 'package:calorix_app/presentation/auth/page/goal_page.dart' as _i4;
import 'package:calorix_app/presentation/auth/page/height_page.dart' as _i5;
import 'package:calorix_app/presentation/auth/page/intro_pages.dart' as _i7;
import 'package:calorix_app/presentation/auth/page/login_page.dart' as _i8;
import 'package:calorix_app/presentation/auth/page/otp_page.dart' as _i9;
import 'package:calorix_app/presentation/auth/page/setting_profile.dart'
    as _i11;
import 'package:calorix_app/presentation/auth/page/splash_page.dart' as _i12;
import 'package:calorix_app/presentation/auth/page/weight_page.dart' as _i13;
import 'package:calorix_app/presentation/dashboard/page/dashboard_page.dart'
    as _i2;
import 'package:calorix_app/presentation/dashboard/page/food_neutration_page.dart'
    as _i3;
import 'package:calorix_app/presentation/dashboard/page/scan_food_page.dart'
    as _i10;
import 'package:calorix_app/presentation/home/page/home_page.dart' as _i6;
import 'package:flutter/material.dart' as _i15;

/// generated route for
/// [_i1.CreateProfilePage]
class CreateProfileRoute extends _i14.PageRouteInfo<void> {
  const CreateProfileRoute({List<_i14.PageRouteInfo>? children})
    : super(CreateProfileRoute.name, initialChildren: children);

  static const String name = 'CreateProfileRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i1.CreateProfilePage();
    },
  );
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i14.PageRouteInfo<void> {
  const DashboardRoute({List<_i14.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardPage();
    },
  );
}

/// generated route for
/// [_i3.FoodNutrientsPage]
class FoodNutrientsRoute extends _i14.PageRouteInfo<FoodNutrientsRouteArgs> {
  FoodNutrientsRoute({
    _i15.Key? key,
    required _i16.FoodScanResponseModel data,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         FoodNutrientsRoute.name,
         args: FoodNutrientsRouteArgs(key: key, data: data),
         initialChildren: children,
       );

  static const String name = 'FoodNutrientsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FoodNutrientsRouteArgs>();
      return _i3.FoodNutrientsPage(key: args.key, data: args.data);
    },
  );
}

class FoodNutrientsRouteArgs {
  const FoodNutrientsRouteArgs({this.key, required this.data});

  final _i15.Key? key;

  final _i16.FoodScanResponseModel data;

  @override
  String toString() {
    return 'FoodNutrientsRouteArgs{key: $key, data: $data}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FoodNutrientsRouteArgs) return false;
    return key == other.key && data == other.data;
  }

  @override
  int get hashCode => key.hashCode ^ data.hashCode;
}

/// generated route for
/// [_i4.GoalPage]
class GoalRoute extends _i14.PageRouteInfo<void> {
  const GoalRoute({List<_i14.PageRouteInfo>? children})
    : super(GoalRoute.name, initialChildren: children);

  static const String name = 'GoalRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.GoalPage();
    },
  );
}

/// generated route for
/// [_i5.HeightPage]
class HeightRoute extends _i14.PageRouteInfo<void> {
  const HeightRoute({List<_i14.PageRouteInfo>? children})
    : super(HeightRoute.name, initialChildren: children);

  static const String name = 'HeightRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.HeightPage();
    },
  );
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomePage();
    },
  );
}

/// generated route for
/// [_i7.IntroPages]
class IntroRoutes extends _i14.PageRouteInfo<void> {
  const IntroRoutes({List<_i14.PageRouteInfo>? children})
    : super(IntroRoutes.name, initialChildren: children);

  static const String name = 'IntroRoutes';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i7.IntroPages();
    },
  );
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i15.Key? key, List<_i14.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i8.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i9.OtpPage]
class OtpRoute extends _i14.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({_i15.Key? key, List<_i14.PageRouteInfo>? children})
    : super(
        OtpRoute.name,
        args: OtpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'OtpRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>(
        orElse: () => const OtpRouteArgs(),
      );
      return _i9.OtpPage(key: args.key);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'OtpRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! OtpRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i10.ScanFoodPage]
class ScanFoodRoute extends _i14.PageRouteInfo<void> {
  const ScanFoodRoute({List<_i14.PageRouteInfo>? children})
    : super(ScanFoodRoute.name, initialChildren: children);

  static const String name = 'ScanFoodRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i10.ScanFoodPage();
    },
  );
}

/// generated route for
/// [_i11.SettingProfilePage]
class SettingProfileRoute extends _i14.PageRouteInfo<void> {
  const SettingProfileRoute({List<_i14.PageRouteInfo>? children})
    : super(SettingProfileRoute.name, initialChildren: children);

  static const String name = 'SettingProfileRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.SettingProfilePage();
    },
  );
}

/// generated route for
/// [_i12.SplashPage]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i12.SplashPage();
    },
  );
}

/// generated route for
/// [_i13.WeightPage]
class WeightRoute extends _i14.PageRouteInfo<void> {
  const WeightRoute({List<_i14.PageRouteInfo>? children})
    : super(WeightRoute.name, initialChildren: children);

  static const String name = 'WeightRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.WeightPage();
    },
  );
}
