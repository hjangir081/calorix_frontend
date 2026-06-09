import 'package:calorix_app/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';

import '../../../presentation/auth/widgets/app_gaps.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_text.dart';

class LeaderboardSummaryCard extends StatelessWidget {
final String averageAdherence;
  const LeaderboardSummaryCard({
    super.key, required this.averageAdherence,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      padding:
      const EdgeInsets.all(24),

      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(30),

        gradient:
        const LinearGradient(
          colors: [
            Color(0xFF1F1F1F),
            Color(0xFF2B2B2B),
          ],
        ),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            AppStrings.averageAdherence,
            style: AppQuicksandText.body(
              context,
            ).copyWith(
              color:
              Colors.white70,
            ),
          ),

          AppGaps.h(
            context,
            8,
          ),

          Text(
            averageAdherence,
            style: AppQuicksandText.heading(context).copyWith(fontSize: 52,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}