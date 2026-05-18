import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:calorix_app/presentation/auth/widgets/app_button.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../domain/models/response/food_scan_response_model.dart';
import '../provider/log_meal_provider.dart';

final selectedMealTypeProvider =
StateProvider<String>((ref) => 'lunch');

final quantityProvider =
StateProvider<int>((ref) => 1);

final consumedPercentageProvider =
StateProvider<int>((ref) => 100);

@RoutePage()
class FoodNutrientsPage extends ConsumerWidget {
  final FoodScanResponseModel data;

  const FoodNutrientsPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final result = data.result;

    final logState = ref.watch(logMealProvider);

    final notifier =
    ref.read(logMealProvider.notifier);

    final selectedMealType =
    ref.watch(selectedMealTypeProvider);

    final quantity =
    ref.watch(quantityProvider);

    final consumedPercentage =
    ref.watch(
      consumedPercentageProvider,
    );

    ref.listen(logMealProvider, (prev, next) {

      if (prev?.isLoading == true &&
          next.isLoading == false) {

        if (next.errorMessage != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(
            SnackBar(
              content: Text(next.errorMessage!),
            ),
          );
        }

        if (next.isSuccess) {
          context.router.replaceAll([
            const DashboardRoute(),
          ]);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => context.router.replaceAll([
            const DashboardRoute(),
          ]),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
          
              Center(
                child: Column(
                  children: [
                    Image.network(
                     'http://localhost:8000${result?.imageUrl}',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
          
                    const SizedBox(height: 10),
          
                    Text(
                      result?.foodName ??
                          "Unknown",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 30),
          
              Container(
                padding:
                const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                ),
                child: Column(
                  children: [
          
                    _item(
                      "Calories",
                      "${result?.nutrition?.calories ?? 0} kcal",
                    ),
          
                    _item(
                      "Protein",
                      "${result?.nutrition?.protein ?? 0} g",
                    ),
          
                    _item(
                      "Carbs",
                      "${result?.nutrition?.carbs ?? 0} g",
                    ),
          
                    _item(
                      "Fat",
                      "${result?.nutrition?.fat ?? 0} g",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
          
              const Text(
                "Quantity",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
          
              const SizedBox(height: 12),
          
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
          
                    GestureDetector(
                      onTap: () {
          
                        if (quantity > 1) {
                          ref
                              .read(
                            quantityProvider.notifier,
                          )
                              .state--;
                        }
                      },
                      child: const CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: 18,
                        child: Icon(Icons.remove),
                      ),
                    ),
          
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
          
                    GestureDetector(
                      onTap: () {
                        ref
                            .read(
                          quantityProvider.notifier,
                        )
                            .state++;
                      },
                      child: const CircleAvatar(
                        backgroundColor:  AppColors.white,
                        radius: 18,
                        child: Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
          
              const SizedBox(height: 24),
          
              Text(
                "Consumed: ${consumedPercentage.toInt()}%",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
          
              Slider(
                value: consumedPercentage.toDouble(),
                min: 1,
                max: 100,
                divisions: 20,
                activeColor: AppColors.secondaryColor,
                inactiveColor: AppColors.secondaryColor.withOpacity(.07),
                label: "${consumedPercentage.toInt()}%",
                onChanged: (value) {
                  ref.read(consumedPercentageProvider.notifier,).state = value.toInt();
                },
              ),
          
              const SizedBox(height: 24),
          
              const Text(
                "Meal Type",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                  FontWeight.w700,
                ),
              ),
          
              const SizedBox(height: 12),
          
              Wrap(
                spacing: 10,
                children: [
          
                  _mealChip(
                    context,
                    ref,
                    'breakfast',
                    selectedMealType,
                  ),
          
                  _mealChip(
                    context,
                    ref,
                    'lunch',
                    selectedMealType,
                  ),
          
                  _mealChip(
                    context,
                    ref,
                    'dinner',
                    selectedMealType,
                  ),
          
                  _mealChip(
                    context,
                    ref,
                    'snack',
                    selectedMealType,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        child: AppPadding(
          child: AppButton(
            text: logState.isLoading
                ? 'Logging...'
                : 'Wanna eat it?',

            onPressed: logState.isLoading
                ? null
                : () {
              notifier.logMeal(
                data,
                selectedMealType,
                quantity,
                consumedPercentage
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

    final isSelected =
        selectedMealType == type;

    return GestureDetector(
      onTap: () {
        ref
            .read(
          selectedMealTypeProvider
              .notifier,
        )
            .state = type;
      },

      child: AnimatedContainer(
        margin: EdgeInsets.only(
          bottom: isSelected ? 0 : AppMediaQuery.bottomPadding(context)*.2,
        ),
        duration:
        const Duration(milliseconds: 250),

        padding: EdgeInsets.symmetric(
          horizontal: AppMediaQuery.width(context)*.06,
          vertical: AppMediaQuery.height(context)*.01,
        ),

        decoration: BoxDecoration(
          color: isSelected
              ? Colors.black
              : Colors.grey.shade200,

          borderRadius:
          BorderRadius.circular(30),
        ),

        child: Text(
          type.toUpperCase(),

          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.black,

            fontWeight:
            FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _item(
      String title,
      String value,
      ) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(
        vertical: 10,
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment
            .spaceBetween,

        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),

          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight:
              FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}