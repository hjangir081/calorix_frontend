import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:calorix_app/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import '../../../../utils/design/app_colors.dart';
import '../../../../utils/design/app_media_query.dart';
import '../../../../utils/design/app_text.dart';
import '../../../domain/models/response/suggest_meal_response_model.dart';
import '../../auth/widgets/app_gaps.dart';

class SuggestedMealsSection extends StatelessWidget {
  final SuggestMealResponseModel?
  suggestedMeals;

  const SuggestedMealsSection({super.key, this.suggestedMeals});

  @override
  Widget build(BuildContext context) {
    final breakfast = suggestedMeals?.result?.breakfast?.firstOrNull;
    return Container(
      margin: EdgeInsets.only(
        bottom: AppMediaQuery.height(context) * .2,
      ),
      width: double.infinity,
      padding: EdgeInsets.all(
        AppMediaQuery.width(context) * .05,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF1E293B)],
        ),
        border: Border.all(
          color: AppColors.divider,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor
                      .withOpacity(.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.restaurant_menu_rounded,
                  color: AppColors.primaryColor,
                ),
              ),

              AppGaps.w(context, 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Meal Plan",
                      style:
                      AppQuicksandText.title(
                        context,
                        color: AppColors.textPrimary
                      ).copyWith(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Personalized for your goal',
                      style:
                      AppQuicksandText.body(
                        context,
                          color: AppColors.textSecondary
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1,
            color: AppColors.surface,
          ),
          AppGaps.h(context, 12),
          if (breakfast != null) ...[
            _MealRow(
              title: 'Breakfast',
              meal: breakfast.name ?? '',
              calories: breakfast.calories ?? 0,
              protein: breakfast.protein ?? 0,
              carbs: breakfast.carbs ?? 0,
              fat: breakfast.fat ?? 0,
            ),
          ],
          AppGaps.h(context, 24),
          GestureDetector(
            onTap: (){context.router.push(SuggestedMealDetailRoute(suggestedMeals: suggestedMeals!));},
            child: Align(
              alignment: .center,
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    AppStrings.viewFullPlan,
                    style: AppQuicksandText.bodyLarge(context).copyWith(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.secondaryColor
                    ),
                  ),
                  Icon(Icons.arrow_forward, size: 17, color: AppColors.secondaryColor)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _MealRow extends StatelessWidget {
  final String title;
  final String meal;
  final int calories;
  final int protein;
  final int carbs;
  final int fat;

  const _MealRow({
    required this.title,
    required this.meal,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            SizedBox(
              width: AppMediaQuery.width(context)*.55,
              child: Text(
                meal,
                style:
                AppQuicksandText.title(
                  context,
                  color: AppColors.textPrimary
                ).copyWith(
                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppMediaQuery.width(context)*.03,
                vertical: AppMediaQuery.height(context)*.005,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius:
                BorderRadius.circular(12),
              ),
              child: Text(
                title,
                style:
                AppQuicksandText.caption(context),
              ),
            ),
          ],
        ),

        AppGaps.h(context, 12),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _MacroChip(
              label: '$calories kcal',
              icon: Icons.local_fire_department,
            ),
            _MacroChip(
              label: '${protein}g Protein',
              icon: Icons.fitness_center,
            ),
            _MacroChip(
              label: '${carbs}g Carbs',
              icon: Icons.grain,
            ),
            _MacroChip(
              label: '${fat}g Fat',
              icon: Icons.water_drop,
            ),
          ],
        ),
      ],
    );
  }
}

class _MacroChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _MacroChip({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color:
        AppColors.primaryColor
            .withOpacity(.08),
        borderRadius:
        BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize:
        MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color:
            AppColors.primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style:
            AppQuicksandText.body(
              context,
              color: AppColors.textSecondary
            ),
          ),
        ],
      ),
    );
  }
}

