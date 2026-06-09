import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/router/app_router.gr.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_media_query.dart';
import '../../../utils/design/app_text.dart';
import '../../auth/providers/auth_provider.dart';
import '../widget/logout_widget.dart';
import '../widget/profile_header.dart';
import '../widget/profile_menu.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        title: Text(
          "Profile"
        ),
      ),
      body: SafeArea(
        child: AppPadding(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: AppMediaQuery.height(context) * .04,
              ),
              child: Column(
                children: [
                  const ProfileHeader(),
                  AppGaps.h24(context),
                  const ProfileMenuTile(
                    title: "Personal Information",
                    icon: Icons.person_outline,
                  ),
                  ProfileMenuTile(
                    title: "Change Password",
                    icon: Icons.lock_outline,
                  ),

                  ProfileMenuTile(
                    title: "Update Goal",
                    icon: Icons.flag_outlined,
                  ),

                  ProfileMenuTile(
                    title: "Meal Preferences",
                    icon: Icons.restaurant_menu,
                  ),

                  ProfileMenuTile(
                    title: "Notifications",
                    icon: Icons.notifications_none,
                  ),

                  ProfileMenuTile(
                    title: "Privacy Policy",
                    icon: Icons.privacy_tip_outlined,
                  ),

                  ProfileMenuTile(
                    title: "Terms & Conditions",
                    icon: Icons.description_outlined,
                  ),

                  ProfileMenuTile(
                    title: "About App",
                    icon: Icons.info_outline,
                  ),

                  AppGaps.h24(context),

                  LogoutButton(
                    onTap: () async {
                      await ref
                          .read(authProvider.notifier)
                          .logout();

                      if (context.mounted) {
                        context.router.replaceAll([
                          LoginRoute(),
                        ]);
                      }
                    },
                  ),

                  AppGaps.h24(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
