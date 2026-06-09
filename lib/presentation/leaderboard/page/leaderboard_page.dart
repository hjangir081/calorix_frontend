import 'package:auto_route/annotations.dart';
import 'package:calorix_app/utils/services/app_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../presentation/auth/widgets/app_gaps.dart';
import '../../../presentation/auth/widgets/app_padding.dart';
import '../provider/leaderboard_progress_provider.dart';
import '../provider/leaderboard_progress_state.dart';
import '../widget/adherence_card.dart';
import '../widget/calories_chart.dart';
import '../widget/leaderboard_insights_card.dart';
import '../widget/leaderboard_stats_row.dart';
import '../widget/leaderboard_summary_card.dart';

@RoutePage()
class LeaderboardPage extends ConsumerWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final leaderboardState = ref.watch(leaderboardProvider);
    ref.listen<LeaderboardState>(leaderboardProvider, (previous, next) {});
    if (leaderboardState.status == LeaderboardStatus.initial) {
      Future.microtask(() {
        ref.read(leaderboardProvider.notifier).getLeaderboard();});
    }
    final data = leaderboardState.data;
    final adherenceDataset =
    data?.chart?.datasets?.firstWhere(
          (e) =>
      e.key ==
          'adherence_pct',
    );
    final caloriesDataset =
    data?.chart?.datasets?.firstWhere(
          (e) =>
      e.key ==
          'calories_consumed',
    );
    final targetDataset =
    data?.chart?.datasets?.firstWhere(
          (e) =>
      e.key ==
          'calories_target',
    );
    return LoaderOverlay(
      isLoading: leaderboardState.status == LeaderboardStatus.loading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          automaticallyImplyActions: false,
          scrolledUnderElevation: 0,
          title: const Text(
            'Leaderboard',
          ),
        ),

        body: SingleChildScrollView(
          child: AppPadding(
            child: Column(
              children: [
                AppGaps.h(
                  context,
                  12,
                ),
                LeaderboardSummaryCard(
                averageAdherence: data?.summary?.avgAdherencePct.toString() ?? '0%',
                ),

                AppGaps.h(context, 24,),

                LeaderboardStatsRow(
                  dailyLogged: data?.summary?.daysLogged.toString() ?? '0',
                  currentStreak: data?.summary?.currentLoggingStreak.toString() ?? '0',
                  bestStreak: data?.summary?.bestLoggingStreak.toString() ?? '0',
                ),

                AdherenceChart(
                  title:
                  adherenceDataset?.label ?? 'N/A',
                  dataset: adherenceDataset,
                  labels: data?.chart?.labels ?? [],
                ),

                CaloriesChart(
                  title:
                  caloriesDataset?.label ??
                      'N/A',

                  dataset:
                  caloriesDataset,

                  targetDataset: targetDataset,

                  labels:
                  data?.chart?.labels ??
                      [],
                ),

                // LeaderboardInsightsCard(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}