import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../config/router/app_router.gr.dart';

@RoutePage()
class SettingProfilePage extends StatelessWidget {
  const SettingProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
      Future.delayed(const Duration(seconds: 4), () {
        context.router.replaceAll([const DashboardRoute()]);
      });
    });
    return Scaffold(
      body:Center(
        child: Lottie.asset(
          AppAnimations.settingProfile,
          width: 400,
          height: 400,
          fit: BoxFit.contain,
        ),
      )
    );
  }
}
