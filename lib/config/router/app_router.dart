import 'package:auto_route/auto_route.dart';

import '../../utils/constants/app_path.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: AppPaths.splashPage, initial: true),
    CustomRoute(
      page: IntroRoutes.page,
      path: AppPaths.introPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: LoginRoute.page,
      path: AppPaths.loginPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: OtpRoute.page,
      path: AppPaths.otpPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: CreateProfileRoute.page,
      path: AppPaths.createProfilePage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: GoalRoute.page,
      path: AppPaths.goalPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: WeightRoute.page,
      path: AppPaths.weightPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: HeightRoute.page,
      path: AppPaths.heightPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: SettingProfileRoute.page,
      path: AppPaths.settingProfilePage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: Duration(milliseconds: 200),
    ),
    AutoRoute(
      page: DashboardRoute.page,
      path: AppPaths.dashboardPage,
      children: [
        AutoRoute(
          page: HomeRoute.page,
          path: AppPaths.homePage,
          initial: true,
        ),

        AutoRoute(
          page: HistoryRoute.page,
          path: AppPaths.historyPage,
        ),

        AutoRoute(
          page: LeaderboardRoute.page,
          path: AppPaths.leaderboardPage,
        ),

        AutoRoute(
          page: ProfileRoute.page,
          path: AppPaths.profilePage,
        ),
      ],
    ),
    CustomRoute(
      page: ScanFoodRoute.page,
      path: AppPaths.scanFoodPage,
      transitionsBuilder: TransitionsBuilders.zoomIn,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: FoodNutrientsRoute.page,
      path: AppPaths.foodNutrientsPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: NotificationRoute.page,
      path: AppPaths.notificationPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: MealsPreferencesRoute.page,
      path: AppPaths.mealsPreferencesPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: SuggestedMealDetailRoute.page,
      path: AppPaths.suggestedMealsDetailPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: Duration(milliseconds: 200),
    ),
    CustomRoute(
      page: MealRecipeDetailRoute.page,
      path: AppPaths.mealRecipeDetailPage,
      transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
      duration: Duration(milliseconds: 200),
    ),
  ];
}