import 'dart:math';
import 'package:flutter/material.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';

class CalorieGauge extends StatelessWidget {
  final int consumed;
  final int total;
  final int burned; // optional (can pass 0)

  const CalorieGauge({
    super.key,
    required this.consumed,
    required this.total,
    this.burned = 0,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
    total > 0 ? (consumed / total).clamp(0.0, 1.0) : 0.0;

    final remaining = (total - consumed).clamp(0, total);
    final net = consumed - burned;

    final isExceeded = consumed > total;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppMediaQuery.height(context) * .012,
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(.04),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "TODAY'S CALORIES",
            style: AppQuicksandText.title(context).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(
            width: AppMediaQuery.width(context) * .6,
            height: AppMediaQuery.height(context) * .15,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  size: Size(
                    AppMediaQuery.width(context) * .55,
                    AppMediaQuery.height(context) * .15,
                  ),
                  painter: _ArcPainter(progress, isExceeded),
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
                            text: "$consumed kcal\n",
                            style: AppQuicksandText.title(context).copyWith(
                              color: isExceeded
                                  ? Colors.red
                                  : AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: "of $total kcal goal",
                            style: AppQuicksandText.body(context).copyWith(
                              color: AppColors.gray,
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

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label,
            style: AppQuicksandText.body(context).copyWith(
              color: AppColors.gray,
            )),
        Text(value,
            style: AppQuicksandText.bodyLarge(context).copyWith(
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final bool isExceeded;

  _ArcPainter(this.progress, this.isExceeded);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height),
      radius: size.width / 2,
    );

    final startAngle = -pi;
    final sweepAngle = pi * progress;

    final bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..shader = LinearGradient(
        colors: isExceeded
            ? [Colors.red, Colors.redAccent]
            : [Colors.red, Colors.orange],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, pi, false, bgPaint);
    canvas.drawArc(rect, startAngle, sweepAngle, false, fgPaint);

    final angle = startAngle + sweepAngle;
    final radius = size.width / 2;

    final dx = size.width / 2 + radius * cos(angle);
    final dy = size.height + radius * sin(angle);

    canvas.drawCircle(
      Offset(dx, dy),
      8,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}