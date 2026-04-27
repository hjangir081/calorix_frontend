import 'package:auto_route/auto_route.dart';

import '../../utils/constants/app_path.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: IntroRoutes.page,
      path: AppPaths.introPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: Duration(milliseconds: 200),
      initial: true
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
    CustomRoute(
      page: DashboardRoute.page,
      path: AppPaths.dashboardPage,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: Duration(milliseconds: 200),
    ),
    AutoRoute(page: HomeRoute.page, path: AppPaths.homePage),
  ];
}