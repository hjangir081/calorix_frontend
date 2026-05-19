import 'package:auto_route/annotations.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/utils/constants/app_images.dart';
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
import '../widget/calorie_gauge.dart';
import '../widget/macronutrient_widget.dart';

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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Container(
          margin: EdgeInsets.only(left: AppMediaQuery.width(context)*.03),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.gray.withOpacity(.5),
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
                    style: AppQuicksandText.bodyLarge(context).copyWith(color: AppColors.gray, fontWeight: FontWeight.w500)
                  ),
                  FutureBuilder<String?>(
                    future: tokenStorage.getName(),
                    builder: (context, snapshot) {

                      return Text(
                        snapshot.data ?? "User",
                        style: AppQuicksandText.title(context)
                            .copyWith(
                          color: AppColors.black,
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
            onTap: () {},
            child: Image.asset(
              AppImages.notificationBell,
              height: AppMediaQuery.height(context) * .03,
            ),
          ),
        ],
      ),
      body: AppPadding(
        child: Column(
          crossAxisAlignment: .center,
          children: [
            AppGaps.h(context, 22),
            CalorieGauge(
              consumed: data?.consumed?.calories ?? 0,
              total: data?.target?.calories ?? 1,
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
                  overTargetValue: data?.overLimits?.fat  ?.overLimitAmount.toString() ?? '',
                  type: MacroType.fat,
                  grams: data?.consumed?.fat ?? 0,
                  targetGrams: data?.target?.fat ?? 0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
