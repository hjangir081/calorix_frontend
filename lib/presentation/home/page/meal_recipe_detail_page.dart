import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/response/suggest_meal_response_model.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_text.dart';

@RoutePage()
class MealRecipeDetailPage extends StatelessWidget {
  final MealItems meal;

  const MealRecipeDetailPage({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Details'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                gradient: const LinearGradient(
                  colors: [Color(0xFF111827), Color(0xFF1E293B)],
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.name ?? '',
                    style: AppQuicksandText.title(
                      context,
                      color: AppColors.textPrimary
                    ).copyWith(fontWeight: FontWeight.bold),
                  ),
                  AppGaps.h8(context),
                  Text(
                    meal.quantity ?? '',
                    style: AppQuicksandText.body(context, color: AppColors.textSecondary),
                  ),
                  AppGaps.h8(context),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _MacroChip(label: '${meal.calories} kcal'),
                      _MacroChip(label: '${meal.protein}g Protein'),
                      _MacroChip(label: '${meal.carbs}g Carbs'),
                      _MacroChip(label: '${meal.fat}g Fat'),
                    ],
                  ),
                ],
              ),
            ),

            AppGaps.h24(context),


            Text(
              'Ingredients',
              style: AppQuicksandText.title(
                context,
                color: AppColors.textPrimary
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            AppGaps.h(context, 14),
            ...(meal.ingredients ?? []).map(
              (ingredient) => Container(
                margin: EdgeInsets.only(bottom: AppMediaQuery.height(context)*.02),
                padding: EdgeInsets.all(AppMediaQuery.width(context)*.05),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [
                    Container(
                      width: AppMediaQuery.width(context)*.03,
                      height: AppMediaQuery.height(context)*.03,
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    AppGaps.w(context, 8),
                    Expanded(child: Text(ingredient.name ?? '')),

                    Text(
                      ingredient.quantity ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            AppGaps.h24(context),
            Text(
              'Instructions',
              style: AppQuicksandText.title(
                context,
                color: AppColors.textPrimary
              ).copyWith(fontWeight: FontWeight.bold),
            ),
            AppGaps.h8(context),
            ...(meal.instructions ?? []).asMap().entries.map(
              (entry) => Container(
                margin: EdgeInsets.only(bottom: AppMediaQuery.height(context)*.02),
                padding: EdgeInsets.all(AppMediaQuery.width(context)*.05),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: AppMediaQuery.width(context)*.07,
                      height: AppMediaQuery.height(context)*.03,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),

                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(child: Text(entry.value)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _MacroChip extends StatelessWidget {
  final String label;
  const _MacroChip({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppMediaQuery.width(context) * 0.03, vertical: AppMediaQuery.height(context)*.01),

      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
