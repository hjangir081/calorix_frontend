// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:calorix_app/presentation/auth/page/create_profile.dart' as _i1;
import 'package:calorix_app/presentation/auth/page/goal_page.dart' as _i3;
import 'package:calorix_app/presentation/auth/page/height_page.dart' as _i4;
import 'package:calorix_app/presentation/auth/page/intro_pages.dart' as _i6;
import 'package:calorix_app/presentation/auth/page/login_page.dart' as _i7;
import 'package:calorix_app/presentation/auth/page/otp_page.dart' as _i8;
import 'package:calorix_app/presentation/auth/page/setting_profile.dart' as _i9;
import 'package:calorix_app/presentation/auth/page/weight_page.dart' as _i10;
import 'package:calorix_app/presentation/dashboard/dashboard_page.dart' as _i2;
import 'package:calorix_app/presentation/home/page/home_page.dart' as _i5;
import 'package:flutter/material.dart' as _i12;

/// generated route for
/// [_i1.CreateProfilePage]
class CreateProfileRoute extends _i11.PageRouteInfo<void> {
  const CreateProfileRoute({List<_i11.PageRouteInfo>? children})
    : super(CreateProfileRoute.name, initialChildren: children);

  static const String name = 'CreateProfileRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.CreateProfilePage();
    },
  );
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i11.PageRouteInfo<void> {
  const DashboardRoute({List<_i11.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardPage();
    },
  );
}

/// generated route for
/// [_i3.GoalPage]
class GoalRoute extends _i11.PageRouteInfo<void> {
  const GoalRoute({List<_i11.PageRouteInfo>? children})
    : super(GoalRoute.name, initialChildren: children);

  static const String name = 'GoalRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.GoalPage();
    },
  );
}

/// generated route for
/// [_i4.HeightPage]
class HeightRoute extends _i11.PageRouteInfo<void> {
  const HeightRoute({List<_i11.PageRouteInfo>? children})
    : super(HeightRoute.name, initialChildren: children);

  static const String name = 'HeightRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.HeightPage();
    },
  );
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomePage();
    },
  );
}

/// generated route for
/// [_i6.IntroPages]
class IntroRoutes extends _i11.PageRouteInfo<void> {
  const IntroRoutes({List<_i11.PageRouteInfo>? children})
    : super(IntroRoutes.name, initialChildren: children);

  static const String name = 'IntroRoutes';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.IntroPages();
    },
  );
}

/// generated route for
/// [_i7.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i12.Key? key, List<_i11.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i7.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i12.Key? key;

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
/// [_i8.OtpPage]
class OtpRoute extends _i11.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({_i12.Key? key, List<_i11.PageRouteInfo>? children})
    : super(
        OtpRoute.name,
        args: OtpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'OtpRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>(
        orElse: () => const OtpRouteArgs(),
      );
      return _i8.OtpPage(key: args.key);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({this.key});

  final _i12.Key? key;

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
/// [_i9.SettingProfilePage]
class SettingProfileRoute extends _i11.PageRouteInfo<void> {
  const SettingProfileRoute({List<_i11.PageRouteInfo>? children})
    : super(SettingProfileRoute.name, initialChildren: children);

  static const String name = 'SettingProfileRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SettingProfilePage();
    },
  );
}

/// generated route for
/// [_i10.WeightPage]
class WeightRoute extends _i11.PageRouteInfo<void> {
  const WeightRoute({List<_i11.PageRouteInfo>? children})
    : super(WeightRoute.name, initialChildren: children);

  static const String name = 'WeightRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.WeightPage();
    },
  );
}
