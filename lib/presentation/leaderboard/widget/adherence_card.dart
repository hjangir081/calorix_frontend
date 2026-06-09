import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/response/leaderboard_progress_response_model.dart';
import '../../../utils/design/app_colors.dart';
import '../widget/leaderboard_chart_card.dart';

class AdherenceChart extends StatelessWidget {
  final String title;
  final Datasets? dataset;
  final List<String> labels;
  const AdherenceChart({
    super.key,
    required this.title,
    required this.dataset,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final spots =
        dataset?.data
            ?.asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), (e.value ?? 0).toDouble()))
            .toList() ??
        [];

    return LeaderboardChartCard(
      title: title,
      child: SizedBox(
        height: AppMediaQuery.height(context) * .3,
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: 100,
            borderData: FlBorderData(show: false),
            gridData: FlGridData(show: true, drawVerticalLine: false),
            titlesData: FlTitlesData(
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),

              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    if (value.toInt() >= labels.length) {
                      return const SizedBox();
                    }

                    final date = labels[value.toInt()];

                    final day = date.split('-').last;

                    return Padding(
                      padding: const EdgeInsets.only(top: 20),

                      child: Text(day),
                    );
                  },
                ),
              ),
            ),

            lineBarsData: [
              LineChartBarData(
                spots: spots,

                isCurved: true,

                color: AppColors.primaryColor,

                barWidth: 5,

                dotData: const FlDotData(show: true),

                belowBarData: BarAreaData(
                  show: true,

                  color: AppColors.primaryColor.withOpacity(.15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
