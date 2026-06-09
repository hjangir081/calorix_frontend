import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/response/suggest_meal_response_model.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_media_query.dart';
import '../../../utils/design/app_text.dart';
import '../../auth/widgets/app_gaps.dart';
import '../../auth/widgets/app_padding.dart';
import '../../../config/router/app_router.gr.dart';

@RoutePage()
class SuggestedMealDetailPage extends StatelessWidget {
  final SuggestMealResponseModel suggestedMeals;

  const SuggestedMealDetailPage({super.key, required this.suggestedMeals});

  @override
  Widget build(BuildContext context) {
    final result = suggestedMeals.result;

    return Scaffold(
      appBar: AppBar(title: const Text('Meal Plan'), centerTitle: true, scrolledUnderElevation: 0,),
      body: SafeArea(
        child: AppPadding(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppGaps.h(context, 12),

                MealSection(
                  title: 'Breakfast',
                  meals: result?.breakfast ?? [],
                ),

                MealSection(
                  title: 'Morning Snack',
                  meals: result?.morningSnack ?? [],
                ),

                MealSection(
                  title: 'Lunch',
                  meals: result?.lunch ?? [],
                ),

                MealSection(
                  title: 'Evening Snack',
                  meals: result?.eveningSnack ?? [],
                ),

                MealSection(
                  title: 'Dinner',
                  meals: result?.dinner ?? [],
                ),

                AppGaps.h(context, 120),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: const NutritionSummary(),
    );
  }
}

class MealSection extends StatelessWidget {
  final String title;
  final List meals;

  const MealSection({
    super.key,
    required this.title,
    required this.meals,
  });

  @override
  Widget build(BuildContext context) {
    if (meals.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: AppQuicksandText.title(
                context,
                color: AppColors.textPrimary
              ).copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),

        AppGaps.h(context, 14),

        ...meals.map((meal) => MealOverviewCard(meal: meal)),

        AppGaps.h(context, 22),
      ],
    );
  }
}

class MealOverviewCard extends StatelessWidget {
  final dynamic meal;

  const MealOverviewCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          MealRecipeDetailRoute(
           meal : meal,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    meal.name ?? '',
                    style: AppQuicksandText.bodyLarge(
                      context,
                      color: AppColors.textPrimary
                    ).copyWith(fontWeight: FontWeight.w700),
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.secondaryColor,
                ),
              ],
            ),

            AppGaps.h(context, 12),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _MacroChip(
                  icon: Icons.local_fire_department,
                  label: '${meal.calories} kcal',
                ),

                _MacroChip(
                  icon: Icons.fitness_center,
                  label: '${meal.protein}g P',
                ),

                _MacroChip(icon: Icons.grain, label: '${meal.carbs}g C'),

                _MacroChip(icon: Icons.water_drop, label: '${meal.fat}g F'),
              ],
            ),

            AppGaps.h(context, 12),

            Row(
              children: [
                Text(
                  'View Recipe',
                  style: AppQuicksandText.body(context).copyWith(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MacroChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MacroChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(.10),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primaryColor),
          const SizedBox(width: 6),
          Text(label, style: AppQuicksandText.body(context, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class NutritionSummary extends StatelessWidget {
  const NutritionSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Material(
        child: Container(
          width: double.infinity,
          padding:  EdgeInsets.symmetric(
            horizontal: AppMediaQuery.width(context) * 0.05,
            vertical: AppMediaQuery.height(context) * 0.02,
          ),
          decoration: const BoxDecoration(
            color: AppColors.background,
          ),
          child: Row(
            children: const [
              Expanded(
                child: SummaryMetric(
                  value: '2587',
                  title: 'Calories',
                ),
              ),
              Expanded(
                child: SummaryMetric(
                  value: '91g',
                  title: 'Protein',
                ),
              ),
              Expanded(
                child: SummaryMetric(
                  value: '394g',
                  title: 'Carbs',
                ),
              ),
              Expanded(
                child: SummaryMetric(
                  value: '72g',
                  title: 'Fat',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SummaryMetric extends StatelessWidget {
  final String value;
  final String title;

  const SummaryMetric({
    super.key,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppQuicksandText.bodyLarge(
            context,
            color: AppColors.textPrimary
          ).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: AppQuicksandText.body(
            context,
            color: AppColors.textSecondary
          ),
        ),
      ],
    );
  }
}