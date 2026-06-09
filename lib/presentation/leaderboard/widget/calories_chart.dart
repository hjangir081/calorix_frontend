import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/response/leaderboard_progress_response_model.dart';
import '../../../utils/design/app_colors.dart';
import '../widget/leaderboard_chart_card.dart';

class CaloriesChart
    extends StatelessWidget {

  final String title;

  final Datasets? dataset;
  final Datasets? targetDataset;
  final List<String> labels;

  const CaloriesChart({
    super.key,
    required this.title,
    required this.dataset,
    required this.labels,
    required this.targetDataset,
  });

  @override
  Widget build(BuildContext context) {

    final values =
        dataset?.data ?? [];
    final targetCalories =
        targetDataset
            ?.data
            ?.first
            .toDouble() ??
            0;

    return LeaderboardChartCard(
      title: title,

      child: SizedBox(
        height:
        AppMediaQuery.height(context)
            * .34,

        child: BarChart(
          BarChartData(
            alignment:
            BarChartAlignment
                .spaceAround,

            maxY:
            _findMaxY(values),

            borderData:
            FlBorderData(
              show: false,
            ),

            gridData:
            FlGridData(
              show: true,
              drawVerticalLine:
              false,
            ),

            titlesData:
            FlTitlesData(

              topTitles:
              const AxisTitles(
                sideTitles:
                SideTitles(
                  showTitles:
                  false,
                ),
              ),

              rightTitles: const AxisTitles(sideTitles:
                SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles:
                  true,
                  reservedSize: 32,
                  getTitlesWidget: (value, meta,) {
                    if (value.toInt() >= labels.length) {
                      return const SizedBox();
                    }
                    final date = labels[value.toInt()];
                    final day = date.split('-',).last;
                    return Padding(
                      padding: const EdgeInsets.only(top: 10,),
                      child: Text(
                        day,
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups: values.asMap().entries.map((e) => _bar(e.key,(e.value ?? 0).toDouble())).toList(),
            extraLinesData:
            ExtraLinesData(
              horizontalLines: [
                HorizontalLine(
                  y: targetCalories,
                  color: AppColors.black,
                  strokeWidth: 3,
                  dashArray: [8, 4],
                  label: HorizontalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    labelResolver: (line) => 'Target',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static double _findMaxY(
      List<dynamic> values,
      ) {

    if (values.isEmpty) {
      return 100;
    }

    final max =
    values
        .map(
          (e) =>
          (e ?? 0)
              .toDouble(),
    )
        .reduce(
          (a, b) =>
      a > b ? a : b,
    );

    return max + 500;
  }

  static BarChartGroupData _bar(
      int x,
      double value,
      ) {

    return BarChartGroupData(
      x: x,

      barRods: [

        BarChartRodData(
          toY: value,

          width: 18,

          borderRadius:
          BorderRadius.circular(
            8,
          ),

          color:
          AppColors.secondaryColor,
        ),
      ],
    );
  }
}