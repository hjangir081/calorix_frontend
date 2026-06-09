import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/constants/app_strings.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_radius.dart';
import '../../../utils/design/app_text.dart';
import '../../auth/widgets/app_gaps.dart';
import '../../auth/widgets/app_textField.dart';
import '../provider/get_agenda_provider.dart';
import '../provider/update_goal_provider.dart';
import '../provider/update_goal_state.dart';

void showUpdateGoalBottomSheet(BuildContext context, WidgetRef ref) {

  String selectedGoal = GoalStrings.maintain;

  final TextEditingController targetWeightController =
  TextEditingController();

  final TextEditingController durationController =
  TextEditingController();

  String selectedDurationType = 'Week';

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {

          return Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            decoration: const BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  'Update Goal',
                  style: AppQuicksandText.title(context, color: AppColors.textPrimary).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 24),

                /// GOAL SELECTION
                Row(
                  children: [

                    _goalChip(
                      title: 'Maintain',
                      selected: selectedGoal == GoalStrings.maintain,
                      onTap: () {
                        setState(() {
                          selectedGoal = GoalStrings.maintain;
                        });
                      },
                    ),

                    const SizedBox(width: 10),

                    _goalChip(
                      title: 'Lose',
                      selected: selectedGoal == GoalStrings.lose,
                      onTap: () {
                        setState(() {
                          selectedGoal = GoalStrings.lose;
                        });
                      },
                    ),

                    const SizedBox(width: 10),

                    _goalChip(
                      title: 'Gain',
                      selected: selectedGoal == GoalStrings.gain,
                      onTap: () {
                        setState(() {
                          selectedGoal = GoalStrings.gain;
                        });
                      },
                    ),
                  ],
                ),

                /// SHOW EXTRA FIELDS ONLY FOR LOSE/GAIN
                if (selectedGoal != GoalStrings.maintain) ...[

                  const SizedBox(height: 24),
                  AppTextField(
                    controller: targetWeightController,
                    keyboardType: TextInputType.number,
                    hint: 'Target Weight (kg)',
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [

                      Expanded(
                        child: AppTextField(
                          controller: durationController,
                          keyboardType: TextInputType.number,
                          hint: AppStrings.duration,
                        ),
                      ),

                      AppGaps.w(context,12),

                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(
                            AppRadius.lg(context),
                          ),
                          border: Border.all(
                            color: AppColors.divider,
                          ),
                        ),

                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.card,
                            iconEnabledColor: AppColors.textPrimary,
                            value: selectedDurationType,
                            style: AppQuicksandText.body(
                              context, color: AppColors.textPrimary
                            ),
                            items: [
                              'Week',
                              'Month',
                              'Quarter',
                            ].map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                            onChanged: (v) {
                              setState(() {
                                selectedDurationType = v!;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      AppColors.primaryColor,
                      foregroundColor:
                      AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () async {
                      await ref.read(updateGoalProvider.notifier,).updateGoal(
                        goal: selectedGoal.toLowerCase(),
                        targetWeightChange: selectedGoal != GoalStrings.maintain ? double.tryParse(targetWeightController.text,) : null,
                        durationValue: selectedGoal != GoalStrings.maintain ? int.tryParse(durationController.text,) : null,
                        durationUnit: selectedGoal != GoalStrings.maintain ? selectedDurationType.toLowerCase() : null,
                      );
                      final updateState =
                      ref.read(
                        updateGoalProvider,
                      );

                      if (updateState.status ==
                          UpdateGoalStatus.success) {

                        await ref
                            .read(
                          agendaProvider
                              .notifier,
                        )
                            .getDailyAgenda();

                        Navigator.pop(
                          context,
                        );
                      }
          },
                    child: const Text(
                      AppStrings.updateGoal,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
Widget _goalChip({
  required String title,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.primaryColor
            : AppColors.surface,
        borderRadius:
        BorderRadius.circular(16),
        border: Border.all(
          color: selected
              ? AppColors.primaryColor
              : AppColors.divider,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected
              ? AppColors.black
              : AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}