import 'package:flutter/material.dart';

import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_media_query.dart';
import '../../../utils/design/app_text.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: AppMediaQuery.width(context) * .28,
          width: AppMediaQuery.width(context) * .28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.surface,
          ),

          child: const Icon(Icons.person, size: 60),
        ),

        SizedBox(height: AppMediaQuery.height(context) * .015),

        Text(
          "Himanshu",
          style: AppQuicksandText.title(
            context,
            color: AppColors.white
          ).copyWith(fontWeight: FontWeight.bold),
        ),

        SizedBox(height: AppMediaQuery.height(context) * .005),

        GestureDetector(
          onTap: () {},
          child: Text(
            "Update Profile",
            style: AppQuicksandText.body(context).copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
