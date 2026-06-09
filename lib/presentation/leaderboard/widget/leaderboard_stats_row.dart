import 'package:flutter/material.dart';

import '../../../presentation/auth/widgets/app_gaps.dart';
import '../../../utils/constants/app_strings.dart';
import 'leaderboard_stats_card.dart';

class LeaderboardStatsRow extends StatelessWidget {
final String dailyLogged;
final String currentStreak;
final String bestStreak;
  const LeaderboardStatsRow({
    super.key, required this.dailyLogged, required this.currentStreak, required this.bestStreak,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        Expanded(
          child: LeaderboardStatCard(
            title: AppStrings.dailyLogged,
            value: dailyLogged,
            icon:
            Icons.calendar_month_rounded,
          ),
        ),

        AppGaps.w(context, 12),

        Expanded(
          child: LeaderboardStatCard(
            title:
            AppStrings.currentStreak,
            value: currentStreak,
            icon:
            Icons
                .local_fire_department_rounded,
          ),
        ),

        AppGaps.w(context, 12),

        Expanded(
          child: LeaderboardStatCard(
            title: AppStrings.bestStreak,
            value: bestStreak,
            icon:
            Icons.emoji_events_rounded,
          ),
        ),
      ],
    );
  }
}