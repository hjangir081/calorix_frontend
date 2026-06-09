import 'package:flutter/material.dart';

import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_media_query.dart';
import '../../../utils/design/app_text.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const ProfileMenuTile({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppMediaQuery.height(context) * .015),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primaryColor),
        title: Text(title, style: AppQuicksandText.bodyLarge(context, color: AppColors.white)),
        trailing: const Icon(Icons.chevron_right),

        onTap: () {},
      ),
    );
  }
}
