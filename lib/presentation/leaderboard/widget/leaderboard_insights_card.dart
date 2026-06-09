import 'package:flutter/material.dart';

import '../../../presentation/auth/widgets/app_gaps.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_text.dart';

class LeaderboardInsightsCard
    extends StatelessWidget {

  const LeaderboardInsightsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,

      padding:
      const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color:
        AppColors.white,

        borderRadius:
        BorderRadius.circular(28),
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Text(
            'Insights',

            style:
            AppQuicksandText.title(
              context,
            ).copyWith(
              fontWeight:
              FontWeight.bold,
            ),
          ),

          AppGaps.h(
            context,
            18,
          ),

          _tile(
            context,
            Icons.trending_up_rounded,
            'Best adherence was on May 17.',
          ),

          _tile(
            context,
            Icons.warning_amber_rounded,
            'You exceeded your calorie target once.',
          ),
        ],
      ),
    );
  }

  Widget _tile(
      BuildContext context,
      IconData icon,
      String text,
      ) {

    return Padding(
      padding:
      const EdgeInsets.only(
        bottom: 16,
      ),

      child: Row(
        children: [

          Container(
            padding:
            const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color:
              AppColors.primaryColor
                  .withOpacity(.2),

              borderRadius:
              BorderRadius.circular(14),
            ),

            child: Icon(
              icon,
              size: 18,
            ),
          ),

          AppGaps.w16(context),

          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}