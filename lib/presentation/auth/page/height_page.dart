import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/utils/constants/app_strings.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/router/app_router.gr.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_text.dart';
import '../providers/profile_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_padding.dart';
import '../widgets/app_gaps.dart';

@RoutePage()
class HeightPage extends ConsumerWidget {
  const HeightPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);
    final int currentHeight = int.tryParse(profileState.height ?? '') ?? 170;

    final controller = FixedExtentScrollController(
      initialItem: currentHeight - 40,
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: AppPadding(
          child: Column(
            crossAxisAlignment: .center,
            children: [
              AppGaps.h(context, 40),
              Text(
                AppStrings.heightQuestion,
                style: AppQuicksandText.title(context, color: AppColors.white)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 50,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          final selected = 40 + index;
                          notifier.updateHeight(selected.toString());
                          notifier.clearHeightError();
                        },
                        controller: controller,
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            final value = 40 + index;
                            return Center(
                              child: Text(
                                "$value cm",
                                style: AppQuicksandText.bodyLarge(context).copyWith(
                                  color: value == currentHeight
                                      ? AppColors.primaryColor
                                      : AppColors.textSecondary,
                                  fontWeight: value == currentHeight
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: value == currentHeight ? 22 : 18,
                                ),
                              ),
                            );
                          },
                          childCount: 181, // 40–220
                        ),
                      ),
                    ),
                    Expanded(
                      child: Opacity(
                        opacity: 0.07,
                        child:  Center(
                          child: SizedBox(
                          width: AppMediaQuery.width(context)*.5,
                          height: AppMediaQuery.height(context)*.4,
                          child: Image.asset(
                            AppImages.person,
                            fit: BoxFit.cover,
                            color: AppColors.white,
                          ),
                        ),
                      )
                    ),
                    )],
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
                    final valid = notifier.validateHeightPage();
                    if (!valid) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(profileState.heightError ?? '')),
                      );
                      return;
                    }
                    debugPrint("Selected height: ${profileState.height} cm");
                    context.router.push(const GoalRoute());
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
