import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/utils/constants/app_images.dart';
import 'package:calorix_app/utils/constants/app_strings.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/di/injector.dart';
import '../../../domain/repositories/token_storage.dart';
import '../../../utils/services/common_functions.dart';
import '../provider/get_agenda_provider.dart';
import '../provider/get_agenda_state.dart';
import '../provider/suggested_meal_provider.dart';
import '../provider/suggested_meal_state.dart';
import '../widget/calorie_gauge.dart';
import '../widget/macronutrient_widget.dart';
import '../widget/suggested_meals_section.dart';
import '../widget/update_goal_sheet.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final tokenStorage = getIt<TokenStorage>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agendaState = ref.watch(agendaProvider);

    if (agendaState.status == AgendaStatus.initial) {
      Future.microtask(() {
        ref.read(agendaProvider.notifier).getDailyAgenda();
      });
    }
    final data = agendaState.data;
    final suggestedMealState =
    ref.watch(suggestedMealProvider);
    if (agendaState.status == AgendaStatus.success && suggestedMealState.status == SuggestedMealStatus.initial){
      Future.microtask(() {
        ref.read(suggestedMealProvider.notifier).getSuggestedMeals();
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        automaticallyImplyActions: false,
        title: Container(
          margin: EdgeInsets.only(left: AppMediaQuery.width(context)*.03),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 20,
                backgroundImage: AssetImage(AppImages.person),
              ),
              AppGaps.w16(context),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getGreeting(),
                    style: AppQuicksandText.bodyLarge(context).copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w500)
                  ),
                  FutureBuilder<String?>(
                    future: tokenStorage.getName(),
                    builder: (context, snapshot) {

                      return Text(
                        snapshot.data ?? "User",
                        style: AppQuicksandText.title(context)
                            .copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        actionsPadding: EdgeInsets.only(
          right: AppMediaQuery.width(context) * .05,
        ),
        actions: [
          GestureDetector(
            onTap: () {context.router.push(NotificationRoute());},
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
              child: Image.asset(
                AppImages.notificationBell,
                height: AppMediaQuery.height(context)*.07,
                width: AppMediaQuery.width(context)*.07,
              ),
            )
          ),
        ],
      ),
      body: AppPadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .center,
            children: [
              AppGaps.h(context, 22),
              CalorieGauge(
                consumed: data?.consumed?.calories ?? 0,
                total: data?.target?.calories ?? 1,
              ),
              AppGaps.h(
                context,
                20,
              ),
          
              GestureDetector(
                onTap: () {
                  showUpdateGoalBottomSheet(context, ref);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(AppMediaQuery.width(context)*0.03),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color:
                        Colors.black.withOpacity(.20),
                        blurRadius: 12,
                        offset: const Offset(0,4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: AppMediaQuery.height(context)*.06,
                        width: AppMediaQuery.width(context)*.13,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(.18),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          Icons.fitness_center_rounded,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                      ),
                      AppGaps.w16(context,),
                      Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    GoalStrings.currentGoal,
                                    style: AppQuicksandText.body(context,).copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                              AppGaps.h4(
                                context,
                              ),
                              Text(
                                  getGoalTitle(
                                    (data?.goal)?.capitalizeFirst,
                                  ),
                                style: AppQuicksandText.title(context).copyWith(
                                  fontWeight:
                                  FontWeight.bold,
                                  color:
                                  AppColors.textPrimary,
                                ),
                              ),
                              AppGaps.h4(context,),
                              Text(
                                'Targeting 0.5 kg per week',
                                style: AppQuicksandText.body(context).copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: AppMediaQuery.width(context)*0.02, vertical: AppMediaQuery.height(context)*0.005),
                        decoration: BoxDecoration(
                          color: data?.goal == GoalStrings.lose ? AppColors.secondaryColor.withOpacity(.18) : AppColors.primaryColor.withOpacity(.12),
                          borderRadius:
                          BorderRadius.circular(
                            16,
                          ),
                        ),
          
                        child: Row(
                          children: [
                            if(data?.goal == GoalStrings.lose || data?.goal == GoalStrings.gain)
                            Icon(
                              data?.goal == GoalStrings.lose ? Icons.trending_down_rounded : Icons.trending_up_rounded,
                              color: data?.goal == GoalStrings.lose ? AppColors.secondaryColor : AppColors.primaryColor,
                              size: 18,
                            ),
          
                            AppGaps.w(
                              context,
                                4
                            ),
          
                            Text(
                              (data?.goal.toString() ?? 'N/A').capitalizeFirst,
                              style: AppQuicksandText.body(
                                context,
                              ).copyWith(
                                fontWeight:
                                FontWeight.bold,
                                color: data?.goal == GoalStrings.lose ? AppColors.secondaryColor : AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppGaps.h(context, 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MacroProgressItem(
                    isOverTarget: data?.overLimits?.protein?.isOverLimit ?? false,
                    type: MacroType.protein,
                    overTargetValue: data?.overLimits?.protein?.overLimitAmount.toString() ?? '',
                    grams: data?.consumed?.protein ?? 0,
                    targetGrams: data?.target?.protein ?? 0,
                  ),
                  MacroProgressItem(
                    isOverTarget: data?.overLimits?.carbs?.isOverLimit ?? false,
                    overTargetValue: data?.overLimits?.carbs?.overLimitAmount.toString() ?? '',
                    type: MacroType.carbs,
                    grams: data?.consumed?.carbs ?? 0,
                    targetGrams: data?.target?.carbs ?? 0,
                  ),
                  MacroProgressItem(
                    isOverTarget: data?.overLimits?.fat?.isOverLimit ?? false,
                    overTargetValue: data?.overLimits?.fat?.overLimitAmount.toString() ?? '',
                    type: MacroType.fat,
                    grams: data?.consumed?.fat ?? 0,
                    targetGrams: data?.target?.fat ?? 0,
                  ),
                ],
              ),
              AppGaps.h(context, 26),
              SuggestedMealsSection(
                suggestedMeals:
                suggestedMealState
                    .suggestedMeals ?? null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
