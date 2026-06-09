import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:calorix_app/presentation/auth/widgets/app_button.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/presentation/auth/widgets/app_textField.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../domain/models/meal_builder_item.dart';
import '../../../domain/models/response/food_scan_response_model.dart';
import '../../auth/widgets/app_gaps.dart';
import '../provider/log_meal_provider.dart';
import '../provider/meal_builder_provider.dart';

final selectedMealTypeProvider = StateProvider<String>((ref) => 'lunch');

@RoutePage()
class FoodNutrientsPage extends ConsumerWidget {
  final FoodScanResponseModel data;

  const FoodNutrientsPage({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = data.result;
    final mealState = ref.watch(mealBuilderProvider);
    final mealNotifier = ref.read(mealBuilderProvider.notifier);
    final logState = ref.watch(logMealProvider);
    final notifier = ref.read(logMealProvider.notifier);
    final selectedMealType = ref.watch(selectedMealTypeProvider);
    Future.microtask(() {

      if (result == null) {
        return;
      }

      /// API could not identify food
      if (result.foodName == 'Unknown Food' ||
          (result.nutrition?.calories ?? 0) <= 0) {
        return;
      }

      /// Prevent duplicate inserts
      if (mealState.items.isNotEmpty) {
        return;
      }

      mealNotifier.clearMeal();

      mealNotifier.addItem(
        MealBuilderItem(
          foodName: result.foodName ?? '',
          imageUrl: result.imageUrl ?? '',
          baseCalories:
          result.nutrition?.calories ?? 0,
          baseProtein:
          result.nutrition?.protein ?? 0,
          baseCarbs:
          result.nutrition?.carbs ?? 0,
          baseFat:
          result.nutrition?.fat ?? 0,
          baseWeightG:
          result.estimatedWeightG ?? 0,
          quantity: 1,
          estimatedWeightG:
          result.estimatedWeightG ?? 0,
        ),
      );
    });

    ref.listen(logMealProvider, (prev, next) {
      if (prev?.isLoading == true && next.isLoading == false) {
        if (next.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
        }
        if (next.isSuccess) {
          ref.read(mealBuilderProvider.notifier).clearMeal();
          context.router.replaceAll([const DashboardRoute()]);
        }
      }
    });
    if (result == null ||
        result.foodName == 'Unknown Food' ||
        (result.nutrition?.calories ?? 0) <= 0) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () => context.router.replaceAll([const DashboardRoute()]),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: const Center(
          child: Text(
            'Unable to identify food from image',
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.router.replaceAll([const DashboardRoute()]),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.router.replaceAll([ScanFoodRoute()]);
            },
            child: Icon(size: 30, Icons.add, color: AppColors.black),
          ),
        ],
      ),

      body: Column(
        children: [
          /// MEAL TYPE
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppMediaQuery.width(context) * .022,
              vertical: AppMediaQuery.height(context) * .01,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _mealChip(context, ref, 'breakfast', selectedMealType),
                  AppGaps.w(context, 12),
                  _mealChip(context, ref, 'lunch', selectedMealType),
                  AppGaps.w(context, 12),
                  _mealChip(context, ref, 'dinner', selectedMealType),
                  AppGaps.w(context, 12),
                  _mealChip(context, ref, 'snack', selectedMealType),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  /// FOOD CARD
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mealState.items.length,
                    itemBuilder: (context, index) {
                      final item = mealState.items[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            /// TOP
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18),
                                  child: item.imageUrl.isNotEmpty
                                      ? Image.network(
                                          'http://localhost:8000${item.imageUrl}',
                                          height: 90,
                                          width: 90,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) {
                                            return _foodPlaceholder(context);
                                          },
                                        )
                                      : _foodPlaceholder(context),
                                ),
                                AppGaps.w16(context),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        item.foodName,
                                        style: AppQuicksandText.title(
                                          context,
                                          color: AppColors.textPrimary
                                        ).copyWith(fontWeight: FontWeight.w700),
                                      ),
                                      AppGaps.h4(context),
                                      Text(
                                        "${item.calories} kcal",
                                        style: AppQuicksandText.body(context)
                                            .copyWith(
                                              color: AppColors.secondaryColor,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                GestureDetector(
                                  onTap: () {
                                    mealNotifier.removeItem(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(AppMediaQuery.height(context)*.01),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(.08),
                                      shape: BoxShape.circle,
                                    ),

                                    child: const Icon(
                                      Icons.close_rounded,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.h8(context),
                            /// NUTRIENTS
                            Row(
                              children: [
                                Expanded(
                                  child: _nutrientItem(
                                    context,
                                    "Protein",
                                    "${item.protein}g",
                                  ),
                                ),

                                Expanded(
                                  child: _nutrientItem(
                                    context,
                                    "Carbs",
                                    "${item.carbs}g",
                                  ),
                                ),

                                Expanded(
                                  child: _nutrientItem(
                                    context,
                                    "Fat",
                                    "${item.fat}g",
                                  ),
                                ),
                              ],
                            ),

                            AppGaps.h8(context),

                            /// WEIGHT
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Estimated Weight",
                                  style: AppQuicksandText.bodyLarge(
                                    context,
                                    color: AppColors.textPrimary
                                  ).copyWith(fontWeight: FontWeight.w600),
                                ),

                                SizedBox(
                                  width: AppMediaQuery.width(context) * .25,

                                  child: AppTextField(
                                    borderColor: false,

                                    textAlignment: TextAlign.center,

                                    initialValue: item.estimatedWeightG
                                        .toString(),

                                    onChanged: (value) {
                                      mealNotifier.updateWeight(
                                        index: index,

                                        grams: int.tryParse(value) ?? 0,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),

                            AppGaps.h8(context),

                            /// QUANTITY
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Text(
                                  "Quantity",
                                  style: AppQuicksandText.bodyLarge(
                                    context,
                                    color: AppColors.textPrimary
                                  ).copyWith(fontWeight: FontWeight.w600),
                                ),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),

                                  decoration: BoxDecoration(
                                    color: AppColors.textSecondary.withOpacity(
                                      .08,
                                    ),

                                    borderRadius: BorderRadius.circular(30),
                                  ),

                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (item.quantity > 1) {
                                            mealNotifier.updateQuantity(
                                              index: index,

                                              quantity: item.quantity - 1,
                                            );
                                          }
                                        },

                                        child: const CircleAvatar(
                                          radius: 16,
                                          backgroundColor: AppColors.white,
                                          child: Icon(Icons.remove, size: 18, color: AppColors.primaryColor,),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 18,
                                        ),
                                        child: Text(
                                          item.quantity.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,

                                            fontSize: 18,
                                          ),
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () {
                                          mealNotifier.updateQuantity(
                                            index: index,
                                            quantity: item.quantity + 1,
                                          );
                                        },
                                        child: const CircleAvatar(
                                          radius: 16,
                                          backgroundColor: AppColors.white,
                                          child: Icon(Icons.add, size: 18, color: AppColors.primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  AppGaps.h24(context),
                  /// TOTAL CARD
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meal Summary",
                          style: AppQuicksandText.title(context).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _summaryItem(
                          "Calories",
                          "${mealState.totalCalories} kcal",
                          context,
                        ),

                        _summaryItem(
                          "Protein",
                          "${mealState.totalProtein} g",
                          context,
                        ),

                        _summaryItem(
                          "Carbs",
                          "${mealState.totalCarbs} g",
                          context,
                        ),

                        _summaryItem("Fat", "${mealState.totalFat} g", context),
                      ],
                    ),
                  ),

                  AppGaps.h(context, 120),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: SafeArea(
        child: AppPadding(
          child: AppButton(
            text: 'Wanna eat it?',
            onPressed: logState.isLoading
                ? null
                : () {
                    notifier.logMeal(
                      mealItems: mealState.items,
                      mealType: selectedMealType,
                    );
                  },
          ),
        ),
      ),
    );
  }

  Widget _mealChip(
    BuildContext context,
    WidgetRef ref,
    String type,
    String selectedMealType,
  ) {
    final isSelected = selectedMealType == type;

    return GestureDetector(
      onTap: () {
        ref.read(selectedMealTypeProvider.notifier).state = type;
      },
      child: AnimatedContainer(
        margin: EdgeInsets.only(
          bottom: isSelected ? 0 : AppMediaQuery.bottomPadding(context) * .2,
        ),
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.width(context) * .06,
          vertical: AppMediaQuery.height(context) * .01,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          type.toUpperCase(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _item(String title, String value, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppMediaQuery.height(context) * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _nutrientItem(BuildContext context, String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppQuicksandText.title(
            context,
            color: AppColors.textPrimary
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        AppGaps.h(context, 4),
        Text(
          title,
          style: AppQuicksandText.caption(
            context,
          ).copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _summaryItem(String title, String value, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppMediaQuery.height(context) * .01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
              style: AppQuicksandText.title(context)
          ),
          Text(
            value,
            style: AppQuicksandText.title(context)
          ),
        ],
      ),
    );
  }

  Widget _foodPlaceholder(BuildContext context) {
    return Container(
      height: AppMediaQuery.height(context) * 0.05,
      width: AppMediaQuery.width(context) * 0.1,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Icon(
        Icons.restaurant_menu_rounded,
        size: 30,
        color: AppColors.primaryColor,
      ),
    );
  }
}
