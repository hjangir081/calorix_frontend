import 'package:auto_route/annotations.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../domain/models/response/get_history_response_model.dart';
import '../../../utils/services/common_functions.dart';
import '../provider/get_history_provider.dart';
import '../provider/get_history_state.dart';

@RoutePage()
class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealHistoryState = ref.watch(mealHistoryProvider);
    final selectedDate = ref.watch(selectedHistoryDateProvider);
    final scrollController = ref.watch(historyDateScrollProvider);
    if (mealHistoryState.status == MealHistoryStatus.initial) {
      Future.microtask(() {
        ref
            .read(mealHistoryProvider.notifier)
            .getMealHistory(
              date: AppDateFormatter.formatDateForApi(selectedDate),
            );
      });
    }
    final data = mealHistoryState.data;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        title: Text(
          'History',
          style: AppQuicksandText.heading(
            context,
          ).copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.w700),
        ),
      ),

      body: AppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
              child: ListView.builder(
                controller: scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  final date = DateTime.now().subtract(
                    Duration(days: 7 - index),
                  );

                  final isSelected =
                      AppDateFormatter.formatDateForApi(date) ==
                      AppDateFormatter.formatDateForApi(selectedDate);

                  return GestureDetector(
                    onTap: () {
                      ref.read(selectedHistoryDateProvider.notifier).state =
                          date;

                      ref
                          .read(mealHistoryProvider.notifier)
                          .getMealHistory(
                            date: AppDateFormatter.formatDateForApi(date),
                          );
                    },

                    child: Container(
                      width: 70,

                      margin: const EdgeInsets.only(right: 12),

                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(22),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            AppDateFormatter.getDayName(date),

                            style: AppQuicksandText.body(context).copyWith(
                              color: isSelected
                                  ? AppColors.black
                                  : AppColors.textSecondary,

                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          AppGaps.h8(context),
                          Text(
                            '${date.day}',
                            style: AppQuicksandText.title(context).copyWith(
                              color: isSelected ? AppColors.black : AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            AppGaps.h(context, 12),
            // DATE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppDateFormatter.formatDate(data?.result?.date),

                      style: AppQuicksandText.title(context).copyWith(
                        fontWeight: FontWeight.w700,

                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            AppGaps.h(context, 26),

            // SUMMARY CARD
            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: AppColors.card,
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(28),
              ),

              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,

                    children: [
                      _calorieValue(
                        context,
                        value:
                            '${data?.result?.summary?.caloriesTarget ?? 'N/A'}',
                        label: 'Goal',
                        color: AppColors.primaryColor,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),

                        child: Text(
                          '-',
                          style: AppQuicksandText.heading(context).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      _calorieValue(
                        context,
                        value:
                            '${data?.result?.summary?.caloriesConsumed ?? 'N/A'}',
                        label: 'Food',
                        color: AppColors.secondaryColor,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),

                        child: Text(
                          '=',
                          style: AppQuicksandText.heading(context).copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      _calorieValue(
                        context,
                        value:
                            '${data?.result?.summary?.remainingCalories ?? 'N/A'}',
                        label: 'Remaining',
                        color: AppColors.white,
                      ),
                    ],
                  ),

                  AppGaps.h8(context),
                ],
              ),
            ),

            AppGaps.h(context, 30),

            Expanded(
              child: DefaultTabController(
                length: 4,
                child: Column(
                  children: [
                    Container(
                      height: AppMediaQuery.height(context) * .07,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,

                        child: TabBar(
                          isScrollable: true,
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                          splashFactory: NoSplash.splashFactory,
                          tabAlignment: TabAlignment.start,

                          labelPadding: EdgeInsets.only(
                            right: AppMediaQuery.width(context) * .02,
                            left: AppMediaQuery.width(context) * .02,
                          ),
                          indicatorPadding: EdgeInsets.zero,

                          dividerColor: Colors.transparent,

                          indicator: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(18),
                          ),

                          labelColor: AppColors.black,

                          unselectedLabelColor: AppColors.textSecondary,

                          labelStyle: AppQuicksandText.body(
                            context,
                          ).copyWith(fontWeight: FontWeight.w700),

                          tabs: [
                            _mealTab(context: context, title: 'Breakfast'),

                            _mealTab(context: context, title: 'Lunch'),

                            _mealTab(context: context, title: 'Dinner'),

                            _mealTab(context: context, title: 'Snack'),
                          ],
                        ),
                      ),
                    ),

                    AppGaps.h(context, 24),

                    Expanded(
                      child: TabBarView(
                        children: [
                          _buildMealList(
                            context,
                            data?.result?.meals?.breakfast?.items,
                          ),
                          _buildMealList(
                            context,
                            data?.result?.meals?.lunch?.items,
                          ),
                          _buildMealList(
                            context,
                            data?.result?.meals?.dinner?.items,
                          ),
                          _buildMealList(
                            context,
                            data?.result?.meals?.snack?.items,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppGaps.h(context, 100),
          ],
        ),
      ),
    );
  }

  Widget _buildMealList(BuildContext context, List<Items>? items) {
    if (items == null || items.isEmpty) {
      return Center(
        child: Text(
          'No meals added',
          style: AppQuicksandText.body(
            context,
          ).copyWith(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      itemCount: items.length,

      itemBuilder: (context, index) {
        final item = items[index];

        return _foodTile(
          context,

          foodName: item.foodName ?? '',

          calories: '${item.calories ?? 0} kcal',

          quantity: '${item.quantity ?? 0} serving',

          protein: '${item.protein ?? 0}g',
        );
      },
    );
  }

  Widget _mealTab({required BuildContext context, required String title}) {
    return Tab(
      child: Container(
        width: AppMediaQuery.width(context) * .25,
        alignment: Alignment.center,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
        child: Text(title),
      ),
    );
  }

  Widget _calorieValue(
    BuildContext context, {
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: AppQuicksandText.heading(
            context,
          ).copyWith(color: color, fontWeight: FontWeight.bold),
        ),

        AppGaps.h4(context),

        Text(
          label,
          style: AppQuicksandText.body(
            context,
          ).copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _foodTile(
    BuildContext context, {
    required String foodName,
    required String calories,
    required String quantity,
    required String protein,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [
          Container(
            height: 62,
            width: 62,

            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(.12),

              borderRadius: BorderRadius.circular(18),
            ),

            child: const Icon(Icons.fastfood_rounded, size: 30),
          ),

          AppGaps.w16(context),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  foodName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: AppQuicksandText.bodyLarge(context).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),

                AppGaps.h4(context),

                Text(
                  quantity,
                  style: AppQuicksandText.body(
                    context,
                  ).copyWith(color: AppColors.textSecondary),
                ),

                AppGaps.h8(context),

                Row(
                  children: [
                    Text(
                      calories,
                      style: AppQuicksandText.body(context).copyWith(
                        color: AppColors.secondaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    AppGaps.w16(context),

                    Text(
                      protein,
                      style: AppQuicksandText.body(context).copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.textSecondary,
            ),

            itemBuilder: (_) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),

              const PopupMenuItem(value: 'delete', child: Text('Delete')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _macroItem(
    BuildContext context, {
    required String title,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          height: 14,
          width: 14,

          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),

        AppGaps.h8(context),

        Text(
          value,
          style: AppQuicksandText.bodyLarge(
            context,
          ).copyWith(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),

        AppGaps.h4(context),

        Text(
          title,
          style: AppQuicksandText.body(
            context,
          ).copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
