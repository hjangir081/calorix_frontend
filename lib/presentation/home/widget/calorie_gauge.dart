import 'dart:math';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';

import '../provider/track_calorie_provider.dart';

class CalorieGauge extends ConsumerWidget {
  const CalorieGauge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calorieProvider);
    final progress = state.consumed / state.goal;

    // Example values (replace with provider logic if available)
    final burned = 320;
    final remaining = state.goal - state.consumed;
    final net = state.consumed - burned;

    return Container(
      padding: EdgeInsets.symmetric(vertical: AppMediaQuery.height(context)*.012),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(.04),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Title
          Text(
            "TODAY'S CALORIES",
            style: AppQuicksandText.title(context).copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          // Gauge
          SizedBox(
            width: AppMediaQuery.width(context) * .6,
            height: AppMediaQuery.height(context) * .15,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  width: AppMediaQuery.width(context) * .55,
                  height: AppMediaQuery.height(context) * .15,
                  child: CustomPaint(painter: _ArcPainter(progress)),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("🔥", style: TextStyle(fontSize: 28)),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppQuicksandText.bodyLarge(context).copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "${state.consumed} kcal\n",
                            style: AppQuicksandText.title(context).copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: "of ${state.goal} kcal goal",
                            style: AppQuicksandText.body(context).copyWith(
                              color: AppColors.gray,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: AppMediaQuery.height(context) * .02),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(label: "Burned", value: "$burned kcal"),
              _StatItem(label: "Remaining", value: "$remaining kcal"),
              _StatItem(label: "Net", value: "$net kcal"),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: AppQuicksandText.body(context).copyWith(
              color: AppColors.gray,
              fontWeight: FontWeight.w500,
            )),
        Text(value,
            style: AppQuicksandText.bodyLarge(context).copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  _ArcPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2,
    );

    final startAngle = -pi; // semicircle start
    final sweepAngle = pi * progress;

    final bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Colors.red, Colors.orange],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    // background arc
    canvas.drawArc(rect, startAngle, pi, false, bgPaint);

    // progress arc
    canvas.drawArc(rect, startAngle, sweepAngle, false, fgPaint);

    // progress dot
    final angle = startAngle + sweepAngle;
    final radius = size.width / 2;
    final dx = size.width / 2 + radius * cos(angle);
    final dy = size.height + radius * sin(angle);

    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(dx, dy), 8, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
