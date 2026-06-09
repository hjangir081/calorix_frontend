import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_media_query.dart';
import '../../../utils/design/app_text.dart';
import '../providers/profile_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_gaps.dart';
import '../widgets/app_padding.dart';

@RoutePage()
class MealsPreferencesPage extends ConsumerWidget {
  const MealsPreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);

    final notifier = ref.read(profileProvider.notifier);

    final dietTypes = [
      {"id": "veg", "title": "Vegetarian"},

      {"id": "non_veg", "title": "Non Vegetarian"},

      {"id": "vegan", "title": "Vegan"},

      {"id": "jain", "title": "Jain"},
    ];

    final cuisines = [
      {"id": "indian", "title": "Indian"},

      {"id": "south_indian", "title": "South Indian"},

      {"id": "north_indian", "title": "North Indian"},

      {"id": "italian", "title": "Italian"},

      {"id": "mexican", "title": "Mexican"},
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
      ),

      body: SafeArea(
        child: AppPadding(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                AppGaps.h(context, 30),

                Text(
                  'Choose your diet type',

                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                AppGaps.h16(context),

                Wrap(
                  spacing: 14,
                  runSpacing: 14,

                  children: dietTypes.map((item) {
                    final selected = state.dietType == item['id'];

                    return GestureDetector(
                      onTap: () {
                        notifier.updateDietType(item['id'] as String);
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),

                        padding: EdgeInsets.symmetric(
                          horizontal: AppMediaQuery.width(context) * .05,

                          vertical: AppMediaQuery.height(context) * .01,
                        ),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),

                          color: selected
                              ? AppColors.primaryColor
                              : Colors.white,

                          border: Border.all(
                            color: selected
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(.04),

                              blurRadius: 10,

                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Text(
                          item['title'] as String,

                          style: AppQuicksandText.body(context).copyWith(
                            fontWeight: FontWeight.w600,

                            color: selected ? AppColors.white : AppColors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                if (state.dietTypeError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),

                    child: Text(
                      state.dietTypeError!,

                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                AppGaps.h24(context),

                Text(
                  'Choose your cuisines',

                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                AppGaps.h16(context),

                Wrap(
                  spacing: 14,
                  runSpacing: 14,

                  children: cuisines.map((item) {
                    final selected = state.cuisines.contains(item['id']);

                    return GestureDetector(
                      onTap: () {
                        notifier.toggleCuisine(item['id'] as String);
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),

                        padding: EdgeInsets.symmetric(
                          horizontal: AppMediaQuery.width(context) * .05,

                          vertical: AppMediaQuery.height(context) * .01,
                        ),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),

                          color: selected
                              ? AppColors.primaryColor
                              : AppColors.white,

                          border: Border.all(
                            color: selected
                                ? AppColors.primaryColor
                                : Colors.grey.shade300,
                          ),

                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(.04),

                              blurRadius: 10,

                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Text(
                          item['title'] as String,

                          style: AppQuicksandText.body(context).copyWith(
                            fontWeight: FontWeight.w600,

                            color: selected ? AppColors.white : AppColors.black,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

                if (state.cuisinesError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),

                    child: Text(
                      state.cuisinesError!,

                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
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
                onPressed: () {context.router.push(SettingProfileRoute());},
              ),

              AppGaps.h16(context),

              GestureDetector(
                onTap: () {
                  context.router.back();
                },

                child: Text(
                  AppBtnStrings.back,

                  style: AppQuicksandText.bodyLarge(context).copyWith(
                    color: AppColors.textSecondary,

                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
