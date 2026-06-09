import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';

enum MacroType { protein, carbs, fat }

extension MacroTypeX on MacroType {
  String get label {
    switch (this) {
      case MacroType.protein:
        return 'Protein';

      case MacroType.carbs:
        return 'Carbs';

      case MacroType.fat:
        return 'Fat';
    }
  }

  Color get color {
    switch (this) {
      case MacroType.protein:
        return Colors.blue;

      case MacroType.carbs:
        return Colors.orange;

      case MacroType.fat:
        return Colors.purple;
    }
  }
}

class MacroProgressItem extends StatelessWidget {
  final MacroType type;
  final int grams;
  final int targetGrams;
  final bool isOverTarget;
  final String overTargetValue;
  const MacroProgressItem({
    super.key,
    required this.type,
    required this.grams,
    required this.targetGrams,
    this.isOverTarget = false,
    this.overTargetValue = "",
  });

  @override
  Widget build(BuildContext context) {
    final progress = targetGrams > 0 ? grams / targetGrams : 0.0;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: AppMediaQuery.height(context) * .01,
      ),

      padding: EdgeInsets.all(AppMediaQuery.width(context) * .024),

      decoration: BoxDecoration(
        color: type.color.withOpacity(0.08),

        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          SizedBox(
            width: AppMediaQuery.width(context) * .24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    type.label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: AppMediaQuery.width(context) * .035,
                      fontWeight: FontWeight.w600,
                      color: type.color,
                    ),
                  ),
                ),
                isOverTarget
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.north_east_outlined,
                            size: 12,
                            color: Colors.red,
                          ),
                          Text(
                            overTargetValue,
                            style: AppQuicksandText.body(context).copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          AppGaps.h4(context),
          Text(
            "$grams g / $targetGrams g",
            style: TextStyle(
              fontSize: AppMediaQuery.width(context) * .032,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          AppGaps.h8(context),
          SizedBox(
            width: AppMediaQuery.width(context) * .2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress.clamp(0, 1),
                minHeight: AppMediaQuery.height(context) * .003,
                backgroundColor: AppColors.textSecondary,
                valueColor: AlwaysStoppedAnimation(type.color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
