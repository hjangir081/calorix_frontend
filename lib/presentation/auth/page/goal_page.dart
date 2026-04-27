import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/utils/constants/app_strings.dart';
import 'package:calorix_app/utils/services/app_snackbar.dart';
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
class GoalPage extends ConsumerWidget {
  const GoalPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: AppPadding(
          child: Column(
            crossAxisAlignment: .center,
            children: [
              AppGaps.h(context, 40),
              Text(
                AppStrings.whatsYourGoal,
                style: AppQuicksandText.title(context)
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              AppGaps.h24(context),

              _buildOption(context, GoalStrings.loseWeight, Icons.trending_down,
                  profileState.goal, notifier.updateGoal),
              _buildOption(context, GoalStrings.maintainWeight, Icons.balance,
                  profileState.goal, notifier.updateGoal),
              _buildOption(context, GoalStrings.gainWeight, Icons.trending_up,
                  profileState.goal, notifier.updateGoal),
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
                text:AppBtnStrings.continueBtn,
                onPressed: () {
                  final valid = notifier.validateGoalPage();

                  if (!valid) {
                    AppTopSnackbar.show(context, profileState.goalError!, type: SnackbarType.error);
                    return;
                  }
                  debugPrint("Profile values:");
                  debugPrint("First Name: ${profileState.firstName}");
                  debugPrint("Last Name: ${profileState.lastName}");
                  debugPrint("Email: ${profileState.email}");
                  debugPrint("DOB: ${profileState.dob}");
                  debugPrint("Gender: ${profileState.gender}");
                  debugPrint("Goal: ${profileState.goal}");
                  debugPrint("Height: ${profileState.height}");
                  debugPrint("Weight: ${profileState.weight}");
                  context.router.replaceAll([const SettingProfileRoute()]);
                },
              ),

              AppGaps.h16(context),
              GestureDetector(
                onTap: (){context.router.back();},
                child: Text(
                  AppBtnStrings.back,
                  style: AppQuicksandText.bodyLarge(context).copyWith(
                    color: AppColors.gray,
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

  Widget _buildOption(BuildContext context, String label, IconData icon,
      String? selectedValue, void Function(String) onSelected) {
    final isSelected = selectedValue == label;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => onSelected(label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : AppColors.gray,
              width: isSelected ? 2 : 1,
            ),
            color: isSelected
                ? AppColors.primaryColor.withOpacity(0.1)
                : Colors.white,
          ),
          child: Row(
            children: [
              Icon(icon,
                  color: isSelected ? AppColors.primaryColor : AppColors.gray),
              const SizedBox(width: 12),
              Text(
                label,
                style: AppQuicksandText.bodyLarge(context).copyWith(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.primaryColor : AppColors.black,
                ),
              ),
              const Spacer(),
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: isSelected ? AppColors.primaryColor : AppColors.gray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
