import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/router/app_router.gr.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_text.dart';
import '../providers/profile_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_padding.dart';
import '../widgets/app_gaps.dart';

@RoutePage()
class WeightPage extends ConsumerWidget {
  const WeightPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);
    final int currentWeight = int.tryParse(profileState.weight ?? '') ?? 62;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: AppPadding(
          child: Column(
            crossAxisAlignment: .center,
            children: [
              AppGaps.h(context, 40),
              Text(
                AppStrings.weightQuestion,
                style: AppQuicksandText.title(context, color: AppColors.white)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              AppGaps.h24(context),
              Text(
                "$currentWeight Kg",
                style: AppQuicksandText.display(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),

              AppGaps.h16(context),
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    final selected = 30 + index;
                    notifier.updateWeight(selected.toString());
                    notifier.clearWeightError();
                  },
                  controller: FixedExtentScrollController(
                    initialItem: currentWeight - 30,
                  ),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final value = 30 + index;
                      return Center(
                        child: Text(
                          "$value",
                          style: AppQuicksandText.bodyLarge(context).copyWith(
                            color: value == currentWeight
                                ? AppColors.primaryColor
                                : AppColors.textSecondary,
                            fontWeight: value == currentWeight
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 20,
                          ),
                        ),
                      );
                    },
                    childCount: 121, // 50–150
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: AppPadding(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppButton(
                  text: AppBtnStrings.continueBtn,
                  onPressed: () {
                    final valid = notifier.validateWeightPage();
                    if (!valid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(profileState.weightError ?? '')),
                      );
                      return;
                    }
                    debugPrint("Selected weight: ${profileState.weight}");
                    context.router.push(const HeightRoute());
                  },
                ),
                AppGaps.h16(context),
                GestureDetector(
                  onTap: (){context.router.back();},
                  child: Text(
                    AppBtnStrings.back,
                    style: AppQuicksandText.bodyLarge(context).copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
