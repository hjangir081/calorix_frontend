// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i16;
import 'package:calorix_app/domain/models/response/food_scan_response_model.dart'
    as _i18;
import 'package:calorix_app/presentation/auth/page/create_profile.dart' as _i1;
import 'package:calorix_app/presentation/auth/page/goal_page.dart' as _i4;
import 'package:calorix_app/presentation/auth/page/height_page.dart' as _i5;
import 'package:calorix_app/presentation/auth/page/intro_pages.dart' as _i8;
import 'package:calorix_app/presentation/auth/page/login_page.dart' as _i9;
import 'package:calorix_app/presentation/auth/page/otp_page.dart' as _i10;
import 'package:calorix_app/presentation/auth/page/setting_profile.dart'
    as _i13;
import 'package:calorix_app/presentation/auth/page/splash_page.dart' as _i14;
import 'package:calorix_app/presentation/auth/page/weight_page.dart' as _i15;
import 'package:calorix_app/presentation/dashboard/page/dashboard_page.dart'
    as _i2;
import 'package:calorix_app/presentation/dashboard/page/food_neutration_page.dart'
    as _i3;
import 'package:calorix_app/presentation/dashboard/page/scan_food_page.dart'
    as _i12;
import 'package:calorix_app/presentation/history/page/history_page.dart' as _i6;
import 'package:calorix_app/presentation/home/page/home_page.dart' as _i7;
import 'package:calorix_app/presentation/profile/page/profile_page.dart'
    as _i11;
import 'package:flutter/material.dart' as _i17;

/// generated route for
/// [_i1.CreateProfilePage]
class CreateProfileRoute extends _i16.PageRouteInfo<void> {
  const CreateProfileRoute({List<_i16.PageRouteInfo>? children})
    : super(CreateProfileRoute.name, initialChildren: children);

  static const String name = 'CreateProfileRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i1.CreateProfilePage();
    },
  );
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i16.PageRouteInfo<void> {
  const DashboardRoute({List<_i16.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardPage();
    },
  );
}

/// generated route for
/// [_i3.FoodNutrientsPage]
class FoodNutrientsRoute extends _i16.PageRouteInfo<FoodNutrientsRouteArgs> {
  FoodNutrientsRoute({
    _i17.Key? key,
    required _i18.FoodScanResponseModel data,
    List<_i16.PageRouteInfo>? children,
  }) : super(
         FoodNutrientsRoute.name,
         args: FoodNutrientsRouteArgs(key: key, data: data),
         initialChildren: children,
       );

  static const String name = 'FoodNutrientsRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FoodNutrientsRouteArgs>();
      return _i3.FoodNutrientsPage(key: args.key, data: args.data);
    },
  );
}

class FoodNutrientsRouteArgs {
  const FoodNutrientsRouteArgs({this.key, required this.data});

  final _i17.Key? key;

  final _i18.FoodScanResponseModel data;

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
class GoalRoute extends _i16.PageRouteInfo<void> {
  const GoalRoute({List<_i16.PageRouteInfo>? children})
    : super(GoalRoute.name, initialChildren: children);

  static const String name = 'GoalRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i4.GoalPage();
    },
  );
}

/// generated route for
/// [_i5.HeightPage]
class HeightRoute extends _i16.PageRouteInfo<void> {
  const HeightRoute({List<_i16.PageRouteInfo>? children})
    : super(HeightRoute.name, initialChildren: children);

  static const String name = 'HeightRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i5.HeightPage();
    },
  );
}

/// generated route for
/// [_i6.HistoryPage]
class HistoryRoute extends _i16.PageRouteInfo<void> {
  const HistoryRoute({List<_i16.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i6.HistoryPage();
    },
  );
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i16.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i17.Key? key, List<_i16.PageRouteInfo>? children})
    : super(
        HomeRoute.name,
        args: HomeRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'HomeRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return _i7.HomePage(key: args.key);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i17.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i8.IntroPages]
class IntroRoutes extends _i16.PageRouteInfo<void> {
  const IntroRoutes({List<_i16.PageRouteInfo>? children})
    : super(IntroRoutes.name, initialChildren: children);

  static const String name = 'IntroRoutes';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i8.IntroPages();
    },
  );
}

/// generated route for
/// [_i9.LoginPage]
class LoginRoute extends _i16.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i17.Key? key, List<_i16.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i9.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i17.Key? key;

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
/// [_i10.OtpPage]
class OtpRoute extends _i16.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({_i17.Key? key, List<_i16.PageRouteInfo>? children})
    : super(
        OtpRoute.name,
        args: OtpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'OtpRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>(
        orElse: () => const OtpRouteArgs(),
      );
      return _i10.OtpPage(key: args.key);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({this.key});

  final _i17.Key? key;

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
/// [_i11.ProfilePage]
class ProfileRoute extends _i16.PageRouteInfo<void> {
  const ProfileRoute({List<_i16.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i11.ProfilePage();
    },
  );
}

/// generated route for
/// [_i12.ScanFoodPage]
class ScanFoodRoute extends _i16.PageRouteInfo<void> {
  const ScanFoodRoute({List<_i16.PageRouteInfo>? children})
    : super(ScanFoodRoute.name, initialChildren: children);

  static const String name = 'ScanFoodRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i12.ScanFoodPage();
    },
  );
}

/// generated route for
/// [_i13.SettingProfilePage]
class SettingProfileRoute extends _i16.PageRouteInfo<void> {
  const SettingProfileRoute({List<_i16.PageRouteInfo>? children})
    : super(SettingProfileRoute.name, initialChildren: children);

  static const String name = 'SettingProfileRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i13.SettingProfilePage();
    },
  );
}

/// generated route for
/// [_i14.SplashPage]
class SplashRoute extends _i16.PageRouteInfo<void> {
  const SplashRoute({List<_i16.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i14.SplashPage();
    },
  );
}

/// generated route for
/// [_i15.WeightPage]
class WeightRoute extends _i16.PageRouteInfo<void> {
  const WeightRoute({List<_i16.PageRouteInfo>? children})
    : super(WeightRoute.name, initialChildren: children);

  static const String name = 'WeightRoute';

  static _i16.PageInfo page = _i16.PageInfo(
    name,
    builder: (data) {
      return const _i15.WeightPage();
    },
  );
}
