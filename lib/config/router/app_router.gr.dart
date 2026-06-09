// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i21;
import 'package:calorix_app/domain/models/response/food_scan_response_model.dart'
    as _i23;
import 'package:calorix_app/domain/models/response/suggest_meal_response_model.dart'
    as _i24;
import 'package:calorix_app/presentation/auth/page/create_profile.dart' as _i1;
import 'package:calorix_app/presentation/auth/page/goal_page.dart' as _i4;
import 'package:calorix_app/presentation/auth/page/height_page.dart' as _i5;
import 'package:calorix_app/presentation/auth/page/intro_pages.dart' as _i8;
import 'package:calorix_app/presentation/auth/page/login_page.dart' as _i10;
import 'package:calorix_app/presentation/auth/page/meals_preferences_page.dart'
    as _i12;
import 'package:calorix_app/presentation/auth/page/otp_page.dart' as _i14;
import 'package:calorix_app/presentation/auth/page/setting_profile.dart'
    as _i17;
import 'package:calorix_app/presentation/auth/page/splash_page.dart' as _i18;
import 'package:calorix_app/presentation/auth/page/weight_page.dart' as _i20;
import 'package:calorix_app/presentation/dashboard/page/dashboard_page.dart'
    as _i2;
import 'package:calorix_app/presentation/dashboard/page/food_neutration_page.dart'
    as _i3;
import 'package:calorix_app/presentation/dashboard/page/scan_food_page.dart'
    as _i16;
import 'package:calorix_app/presentation/history/page/history_page.dart' as _i6;
import 'package:calorix_app/presentation/home/page/home_page.dart' as _i7;
import 'package:calorix_app/presentation/home/page/meal_recipe_detail_page.dart'
    as _i11;
import 'package:calorix_app/presentation/home/page/suggested_meal_detail_page.dart'
    as _i19;
import 'package:calorix_app/presentation/leaderboard/page/leaderboard_page.dart'
    as _i9;
import 'package:calorix_app/presentation/notification/page/notification_page.dart'
    as _i13;
import 'package:calorix_app/presentation/profile/page/profile_page.dart'
    as _i15;
import 'package:flutter/material.dart' as _i22;

/// generated route for
/// [_i1.CreateProfilePage]
class CreateProfileRoute extends _i21.PageRouteInfo<void> {
  const CreateProfileRoute({List<_i21.PageRouteInfo>? children})
    : super(CreateProfileRoute.name, initialChildren: children);

  static const String name = 'CreateProfileRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i1.CreateProfilePage();
    },
  );
}

/// generated route for
/// [_i2.DashboardPage]
class DashboardRoute extends _i21.PageRouteInfo<void> {
  const DashboardRoute({List<_i21.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardPage();
    },
  );
}

/// generated route for
/// [_i3.FoodNutrientsPage]
class FoodNutrientsRoute extends _i21.PageRouteInfo<FoodNutrientsRouteArgs> {
  FoodNutrientsRoute({
    _i22.Key? key,
    required _i23.FoodScanResponseModel data,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         FoodNutrientsRoute.name,
         args: FoodNutrientsRouteArgs(key: key, data: data),
         initialChildren: children,
       );

  static const String name = 'FoodNutrientsRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FoodNutrientsRouteArgs>();
      return _i3.FoodNutrientsPage(key: args.key, data: args.data);
    },
  );
}

class FoodNutrientsRouteArgs {
  const FoodNutrientsRouteArgs({this.key, required this.data});

  final _i22.Key? key;

  final _i23.FoodScanResponseModel data;

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
class GoalRoute extends _i21.PageRouteInfo<void> {
  const GoalRoute({List<_i21.PageRouteInfo>? children})
    : super(GoalRoute.name, initialChildren: children);

  static const String name = 'GoalRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i4.GoalPage();
    },
  );
}

/// generated route for
/// [_i5.HeightPage]
class HeightRoute extends _i21.PageRouteInfo<void> {
  const HeightRoute({List<_i21.PageRouteInfo>? children})
    : super(HeightRoute.name, initialChildren: children);

  static const String name = 'HeightRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i5.HeightPage();
    },
  );
}

/// generated route for
/// [_i6.HistoryPage]
class HistoryRoute extends _i21.PageRouteInfo<void> {
  const HistoryRoute({List<_i21.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i6.HistoryPage();
    },
  );
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i21.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i22.Key? key, List<_i21.PageRouteInfo>? children})
    : super(
        HomeRoute.name,
        args: HomeRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'HomeRoute';

  static _i21.PageInfo page = _i21.PageInfo(
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

  final _i22.Key? key;

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
class IntroRoutes extends _i21.PageRouteInfo<void> {
  const IntroRoutes({List<_i21.PageRouteInfo>? children})
    : super(IntroRoutes.name, initialChildren: children);

  static const String name = 'IntroRoutes';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i8.IntroPages();
    },
  );
}

/// generated route for
/// [_i9.LeaderboardPage]
class LeaderboardRoute extends _i21.PageRouteInfo<void> {
  const LeaderboardRoute({List<_i21.PageRouteInfo>? children})
    : super(LeaderboardRoute.name, initialChildren: children);

  static const String name = 'LeaderboardRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i9.LeaderboardPage();
    },
  );
}

/// generated route for
/// [_i10.LoginPage]
class LoginRoute extends _i21.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i22.Key? key, List<_i21.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i10.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i22.Key? key;

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
/// [_i11.MealRecipeDetailPage]
class MealRecipeDetailRoute
    extends _i21.PageRouteInfo<MealRecipeDetailRouteArgs> {
  MealRecipeDetailRoute({
    _i22.Key? key,
    required _i24.MealItems meal,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         MealRecipeDetailRoute.name,
         args: MealRecipeDetailRouteArgs(key: key, meal: meal),
         initialChildren: children,
       );

  static const String name = 'MealRecipeDetailRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MealRecipeDetailRouteArgs>();
      return _i11.MealRecipeDetailPage(key: args.key, meal: args.meal);
    },
  );
}

class MealRecipeDetailRouteArgs {
  const MealRecipeDetailRouteArgs({this.key, required this.meal});

  final _i22.Key? key;

  final _i24.MealItems meal;

  @override
  String toString() {
    return 'MealRecipeDetailRouteArgs{key: $key, meal: $meal}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MealRecipeDetailRouteArgs) return false;
    return key == other.key && meal == other.meal;
  }

  @override
  int get hashCode => key.hashCode ^ meal.hashCode;
}

/// generated route for
/// [_i12.MealsPreferencesPage]
class MealsPreferencesRoute extends _i21.PageRouteInfo<void> {
  const MealsPreferencesRoute({List<_i21.PageRouteInfo>? children})
    : super(MealsPreferencesRoute.name, initialChildren: children);

  static const String name = 'MealsPreferencesRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i12.MealsPreferencesPage();
    },
  );
}

/// generated route for
/// [_i13.NotificationPage]
class NotificationRoute extends _i21.PageRouteInfo<void> {
  const NotificationRoute({List<_i21.PageRouteInfo>? children})
    : super(NotificationRoute.name, initialChildren: children);

  static const String name = 'NotificationRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i13.NotificationPage();
    },
  );
}

/// generated route for
/// [_i14.OtpPage]
class OtpRoute extends _i21.PageRouteInfo<OtpRouteArgs> {
  OtpRoute({_i22.Key? key, List<_i21.PageRouteInfo>? children})
    : super(
        OtpRoute.name,
        args: OtpRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'OtpRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<OtpRouteArgs>(
        orElse: () => const OtpRouteArgs(),
      );
      return _i14.OtpPage(key: args.key);
    },
  );
}

class OtpRouteArgs {
  const OtpRouteArgs({this.key});

  final _i22.Key? key;

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
/// [_i15.ProfilePage]
class ProfileRoute extends _i21.PageRouteInfo<void> {
  const ProfileRoute({List<_i21.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i15.ProfilePage();
    },
  );
}

/// generated route for
/// [_i16.ScanFoodPage]
class ScanFoodRoute extends _i21.PageRouteInfo<void> {
  const ScanFoodRoute({List<_i21.PageRouteInfo>? children})
    : super(ScanFoodRoute.name, initialChildren: children);

  static const String name = 'ScanFoodRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i16.ScanFoodPage();
    },
  );
}

/// generated route for
/// [_i17.SettingProfilePage]
class SettingProfileRoute extends _i21.PageRouteInfo<void> {
  const SettingProfileRoute({List<_i21.PageRouteInfo>? children})
    : super(SettingProfileRoute.name, initialChildren: children);

  static const String name = 'SettingProfileRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i17.SettingProfilePage();
    },
  );
}

/// generated route for
/// [_i18.SplashPage]
class SplashRoute extends _i21.PageRouteInfo<void> {
  const SplashRoute({List<_i21.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i18.SplashPage();
    },
  );
}

/// generated route for
/// [_i19.SuggestedMealDetailPage]
class SuggestedMealDetailRoute
    extends _i21.PageRouteInfo<SuggestedMealDetailRouteArgs> {
  SuggestedMealDetailRoute({
    _i22.Key? key,
    required _i24.SuggestMealResponseModel suggestedMeals,
    List<_i21.PageRouteInfo>? children,
  }) : super(
         SuggestedMealDetailRoute.name,
         args: SuggestedMealDetailRouteArgs(
           key: key,
           suggestedMeals: suggestedMeals,
         ),
         initialChildren: children,
       );

  static const String name = 'SuggestedMealDetailRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SuggestedMealDetailRouteArgs>();
      return _i19.SuggestedMealDetailPage(
        key: args.key,
        suggestedMeals: args.suggestedMeals,
      );
    },
  );
}

class SuggestedMealDetailRouteArgs {
  const SuggestedMealDetailRouteArgs({this.key, required this.suggestedMeals});

  final _i22.Key? key;

  final _i24.SuggestMealResponseModel suggestedMeals;

  @override
  String toString() {
    return 'SuggestedMealDetailRouteArgs{key: $key, suggestedMeals: $suggestedMeals}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SuggestedMealDetailRouteArgs) return false;
    return key == other.key && suggestedMeals == other.suggestedMeals;
  }

  @override
  int get hashCode => key.hashCode ^ suggestedMeals.hashCode;
}

/// generated route for
/// [_i20.WeightPage]
class WeightRoute extends _i21.PageRouteInfo<void> {
  const WeightRoute({List<_i21.PageRouteInfo>? children})
    : super(WeightRoute.name, initialChildren: children);

  static const String name = 'WeightRoute';

  static _i21.PageInfo page = _i21.PageInfo(
    name,
    builder: (data) {
      return const _i20.WeightPage();
    },
  );
}
