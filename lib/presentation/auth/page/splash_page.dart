import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/config/di/injector.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:calorix_app/domain/repositories/token_storage.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
   _init(context);

    return Scaffold(
      body: AppPadding(
        child: const SafeArea(
          child: Center(
            child: Text('Calorix'),
          ),
        ),
      ),
    );
  }

  Future<void> _init(BuildContext context) async {
    final storage = getIt<TokenStorage>();

    await Future.delayed(const Duration(seconds: 2));

    final isIntroSeen = await storage.isIntroSeen();
    final accessToken = await storage.getAccessToken();
    if (!context.mounted) return;
    if (!isIntroSeen) {
      context.router.replaceAll([IntroRoutes()]);
    } else if (accessToken != null && accessToken.isNotEmpty) {
      context.router.replaceAll([const DashboardRoute()]);
    } else {
      context.router.replaceAll([LoginRoute()]);
    }
  }
}