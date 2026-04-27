import 'package:auto_route/annotations.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/utils/constants/app_images.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';

import '../../../utils/services/common_functions.dart';
import '../widget/calorie_gauge.dart';
import '../widget/macronutrient_widget.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  Text(
                    "John Doe",
                      style: AppQuicksandText.title(context).copyWith(color: AppColors.black, fontWeight: FontWeight.w600)
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
            CalorieGauge(),
            AppGaps.h(context, 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MacroProgressItem(title: "Protein", grams: 120, totalCalories: 2213),
                MacroProgressItem(title: "Carbs", grams: 250, totalCalories: 2213),
                MacroProgressItem(title: "Fat", grams: 70, totalCalories: 2213),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
