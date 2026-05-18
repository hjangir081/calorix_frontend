import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/router/app_router.gr.dart';
import '../../auth/providers/auth_provider.dart';

@RoutePage()
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        automaticallyImplyLeading: false,
        actions: [

          IconButton(
            onPressed: () async {
              await ref
                  .read(authProvider.notifier)
                  .logout();
              if (context.mounted) {
                context.router.replaceAll([
                  LoginRoute(),
                ]);
              }
            },

            icon: const Icon(
              Icons.logout_rounded,
            ),
          ),
        ],
      ),
    );
  }
}