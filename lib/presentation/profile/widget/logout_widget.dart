import 'package:flutter/material.dart';

import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_media_query.dart';
import '../../../utils/design/app_text.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const LogoutButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Text(
          "Logout",
          style: AppQuicksandText.title(
            context,
            color: AppColors.danger
          ).copyWith(fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
