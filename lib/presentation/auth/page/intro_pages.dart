import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/presentation/auth/widgets/app_button.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/utils/constants/app_images.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/router/app_router.gr.dart';
import '../../../utils/constants/app_strings.dart';
import '../../provider/intro_provider.dart';

@RoutePage()
class IntroPages extends ConsumerWidget {
  const IntroPages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(introIndexProvider);
    final notifier = ref.read(introIndexProvider.notifier);

    final data = introData[index];

    void nextPage() {
      if (index < introData.length - 1) {
        notifier.state++;
      } else {
        context.router.replaceAll([DashboardRoute()]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          AppPadding(
            child: GestureDetector(
              onTap: (){context.router.replaceAll([LoginRoute()]);},
              child: Text(
                AppBtnStrings.skip,
                style: AppQuicksandText.title(
                  context,
                ).copyWith(fontWeight: FontWeight.bold, color: AppColors.gray),
              ),
            )
          ),
        ],
      ),
      body: SafeArea(
        child: AppPadding(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: AppMediaQuery.height(context) * .35,
                width: double.infinity,
                child: ClipRRect(
                  child: Image.asset(AppImages.onBoardFruitBowl),
                ),
              ),
              AppGaps.h(context, 38),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppQuicksandText.heading(
                    context,
                  ).copyWith(fontWeight: FontWeight.bold, color: Colors.black),
                  children: data.titleParts.map((part) {
                    return TextSpan(
                      text: part.text,
                      style: AppQuicksandText.heading(context).copyWith(
                        color: part.color ?? AppColors.black,
                        fontSize: 20,
                      ),
                    );
                  }).toList(),
                ),
              ),
              AppGaps.h8(context),
              Text(
                data.subtitle,
                textAlign: TextAlign.center,
                style: AppQuicksandText.body(context).copyWith(
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: AppPadding(
          child: AppButton(
            text: index == introData.length - 1 ? AppBtnStrings.getStarted : AppBtnStrings.next,
            onPressed: nextPage,
          ),
        ),
      ),
    );
  }
}
