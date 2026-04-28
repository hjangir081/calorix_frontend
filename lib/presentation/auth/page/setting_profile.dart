import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/utils/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../config/router/app_router.gr.dart';
import '../providers/profile_provider.dart';
import '../providers/profile_state.dart';

@RoutePage()
class SettingProfilePage extends ConsumerWidget {
  const SettingProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // ✅ Listen to profile state
    ref.listen(profileProvider, (prev, next) {
      if (next.status == ProfileStatus.success &&
          prev?.status != ProfileStatus.success) {

        Future.delayed(const Duration(milliseconds: 1500), () {
          context.router.replaceAll([const DashboardRoute()]);
        });
      }

      if (next.status == ProfileStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage ?? "Something went wrong"),
          ),
        );
        context.router.back();
      }
    });

    // ✅ Call API only once
    final profileState = ref.watch(profileProvider);

    if (profileState.status == ProfileStatus.initial) {
      Future.microtask(() {
        ref.read(profileProvider.notifier).submitProfile();
      });
    }

    return Scaffold(
      body: Center(
        child: Lottie.asset(
          AppAnimations.settingProfile,
          width: 400,
          height: 400,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
