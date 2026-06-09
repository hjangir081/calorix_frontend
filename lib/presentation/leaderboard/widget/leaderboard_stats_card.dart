import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:flutter/material.dart';

import '../../../presentation/auth/widgets/app_gaps.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_text.dart';

class LeaderboardStatCard
    extends StatelessWidget {

  final String title;
  final String value;
  final IconData icon;

  const LeaderboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding:
      EdgeInsets.symmetric(
        vertical: AppMediaQuery.width(context)*.04,
      ),

      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.divider),
        borderRadius:
        BorderRadius.circular(24),
      ),

      child: Column(
        children: [

          Icon(
            icon,
            color:
            AppColors.primaryColor,
          ),

          AppGaps.h(
            context,
            10,
          ),

          Text(
            value,
            style:
            AppQuicksandText.title(
              context,
              color: AppColors.textSecondary
            ).copyWith(
              fontWeight:
              FontWeight.bold,
            ),
          ),

          AppGaps.h4(
            context,
          ),

          Text(
            title,

            textAlign:
            TextAlign.center,

            style:
            AppQuicksandText.body(
              context,
            ).copyWith(
              color:
              AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}