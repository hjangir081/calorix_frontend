import 'dart:math';
import 'package:flutter/material.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';

class CalorieGauge extends StatelessWidget {
  final int consumed;
  final int total;
  final int burned;

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

    final remaining = max(total - consumed, 0);
    final net = max(consumed - burned, 0);

    final isExceeded = consumed > total;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppMediaQuery.height(context) * .012,
      ),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(
          color: AppColors.divider,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            "TODAY'S CALORIES",
            style: AppQuicksandText.title(context, color: AppColors.textPrimary).copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(
            width: AppMediaQuery.width(context) * .65,
            height: AppMediaQuery.height(context) * .17,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 900),
              curve: Curves.easeOutCubic,
              builder: (context, animatedProgress, child) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    CustomPaint(
                      size: Size(
                        AppMediaQuery.width(context) * .58,
                        AppMediaQuery.height(context) * .16,
                      ),
                      painter: _ArcPainter(
                        animatedProgress,
                        isExceeded,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "🔥",
                            style: TextStyle(fontSize: 30),
                          ),

                          TweenAnimationBuilder<int>(
                            tween: IntTween(
                              begin: 0,
                              end: consumed,
                            ),
                            duration:
                            const Duration(milliseconds: 900),
                            builder: (context, value, child) {
                              return RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: AppQuicksandText.bodyLarge(context)
                                      .copyWith(
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "$value kcal\n",
                                      style: AppQuicksandText.title(context)
                                          .copyWith(
                                        color: isExceeded
                                            ? AppColors.danger
                                            : AppColors.textPrimary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: "of $total kcal goal",
                                      style: AppQuicksandText.body(context)
                                          .copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          SizedBox(height: AppMediaQuery.height(context) * .02),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatItem(
                label: "Burned",
                value: "$burned kcal",
              ),
              _StatItem(
                label: "Remaining",
                value: "$remaining kcal",
              ),
              _StatItem(
                label: "Net",
                value: "$net kcal",
              ),
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
        Text(
          label,
          style: AppQuicksandText.body(context).copyWith(
            color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppQuicksandText.bodyLarge(context, color: AppColors.textPrimary,).copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
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

    const strokeWidth = 18.0;

    final bgPaint = Paint()
      ..color = AppColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..shader = LinearGradient(
        colors: isExceeded
            ? [
          AppColors.warning,
          AppColors.danger,
        ]
            : [
          AppColors.primaryColor,
          AppColors.secondaryColor,
        ],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // background
    canvas.drawArc(
      rect,
      -pi,
      pi,
      false,
      bgPaint,
    );

    // progress
    canvas.drawArc(
      rect,
      -pi,
      pi * progress,
      false,
      fgPaint,
    );

    // thumb
    final angle = -pi + (pi * progress);

    final radius = size.width / 2;

    final dx = size.width / 2 + radius * cos(angle);
    final dy = size.height + radius * sin(angle);

    canvas.drawCircle(
      Offset(dx, dy),
      9,
      Paint()..color = AppColors.surface,
    );

    canvas.drawCircle(
      Offset(dx, dy),
      5,
      Paint()
        ..color = isExceeded
            ? AppColors.danger
            : AppColors.primaryColor
    );
  }

  @override
  bool shouldRepaint(covariant _ArcPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.isExceeded != isExceeded;
  }
}