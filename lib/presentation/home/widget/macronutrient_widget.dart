import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:flutter/material.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';

class MacroProgressItem extends StatelessWidget {
  final String title;
  final int grams;
  final int totalCalories;

  const MacroProgressItem({
    super.key,
    required this.title,
    required this.grams,
    required this.totalCalories,
  });

  @override
  Widget build(BuildContext context) {
    final int calories = title.toLowerCase() == "protein"
        ? grams * 4
        : title.toLowerCase() == "carbs"
        ? grams * 4
        : title.toLowerCase() == "fat"
        ? grams * 9
        : 0;

    final double progress = totalCalories > 0 ? calories / totalCalories : 0;

    final Color color = title.toLowerCase() == "protein"
        ? Colors.blue
        : title.toLowerCase() == "carbs"
        ? Colors.orange
        : title.toLowerCase() == "fat"
        ? Colors.purple
        : Colors.grey;

    return Container(
      margin: EdgeInsets.symmetric(vertical: AppMediaQuery.height(context) * .01),
      padding: EdgeInsets.all(AppMediaQuery.width(context) * .03),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title + value
              Text(title,
                  style: TextStyle(
                    fontSize: AppMediaQuery.width(context) * .035,
                    fontWeight: FontWeight.w600,
                    color: color,
                  )),
          AppGaps.h4(context),
          Text("$grams g",
              style: TextStyle(
                fontSize: AppMediaQuery.width(context) * .032,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              )),
          AppGaps.h8(context),

          SizedBox(
            width: AppMediaQuery.width(context) * .2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress.clamp(0, 1),
                minHeight: AppMediaQuery.height(context) * .003,
                backgroundColor: Colors.grey.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


