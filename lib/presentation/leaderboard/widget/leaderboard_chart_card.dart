import 'package:flutter/material.dart';

import '../../../presentation/auth/widgets/app_gaps.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_text.dart';

class LeaderboardChartCard extends StatelessWidget {
  final String title;
  final Widget child;

  const LeaderboardChartCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: AppColors.card,

        borderRadius: BorderRadius.circular(28),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            title,
            style: AppQuicksandText.title(
              context,
              color: AppColors.textSecondary,
            ).copyWith(fontWeight: FontWeight.bold),
          ),

          AppGaps.h(context, 24),

          child,
        ],
      ),
    );
  }
}
