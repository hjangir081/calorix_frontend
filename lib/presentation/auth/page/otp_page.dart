import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/presentation/widgets/otp_input_field.dart';
import 'package:calorix_app/utils/design/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/design/app_media_query.dart';
import '../../../utils/design/app_responsive.dart';
import '../../../utils/design/app_text.dart';
import '../../../utils/services/app_loader.dart';
import '../../../utils/services/app_snackbar.dart';
import '../../../utils/validators/app_validators.dart';
import '../../provider/otp_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';
import '../widgets/app_button.dart';
import '../widgets/app_gaps.dart';

@RoutePage()
class OtpPage extends ConsumerWidget {
  OtpPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);
    final otpNotifier = ref.read(otpNotifierProvider.notifier);
    final seconds = ref.watch(otpTimerProvider);
    final timerNotifier = ref.read(otpTimerProvider.notifier);
    ref.listen(authProvider, (prev, next) {
      if (next.status == AuthStatus.success &&
          prev?.status != AuthStatus.success) {
        notifier.updateOtp('');
        notifier.updatePhone('');
        otpNotifier.clear();
        final res = next.response;

        if (res?.result?.isRegistered == true) {
          context.router.replaceAll([DashboardRoute()]);
        } else {
          context.router.push(CreateProfileRoute());
        }
      }

      if (next.status == AuthStatus.error) {
        AppTopSnackbar.show(
          context,
          next.errorMessage ?? 'Invalid OTP',
          type: SnackbarType.error,
        );
        notifier.reset();
      }
    });
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ));

    return LoaderOverlay(
        isLoading: authState.status == AuthStatus.loading,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              automaticallyImplyActions: false,
            ),
            bottomNavigationBar: SafeArea(
                child: SingleChildScrollView(
                  child: AppPadding(
                    child: AppButton(
                      text: AppBtnStrings.verifyOtp,
                      onPressed: () {
                        if (authState.otpText.length < 4) {
                          AppTopSnackbar.show(
                            context,
                            'Please enter the OTP',
                            type: SnackbarType.error,
                          );
                          return;
                        }
                        notifier.verifyOtp(authState.otpText);
                      },
                    ),
                  ),
                )
            ),
            body: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    AppImages.loginBg,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(bottom: AppMediaQuery.height(context)*.2, top: AppMediaQuery.height(context)*.02),
                    constraints: BoxConstraints(
                      maxHeight: AppResponsive.bottomSheetLarge(context),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    child: SafeArea(
                      top: false,
                      child: SingleChildScrollView(
                        child: AppPadding(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.verifyYourNumber,
                                style: AppQuicksandText.display(context, color: AppColors.white).copyWith(fontWeight: FontWeight.bold),
                              ),
                              AppGaps.h16(context),
                              Text(
                                AppStrings.sentCode,
                                style: AppQuicksandText.bodyLarge(context, color: AppColors.white),
                              ),
                              AppGaps.h16(context),
                              OtpInputField(
                                onChanged: (val) => notifier.updateOtp(val),
                                onCompleted: (val) {
                                  notifier.updateOtp(val);

                                  if (val.length < 4) return;

                                  notifier.verifyOtp(val);
                                },
                              ),
                              AppGaps.h16(context),
                              seconds == 0
                                  ? GestureDetector(
                                onTap: () {
                                  timerNotifier.resend();
                                  // call resend OTP API here
                                },
                                child: Text(
                                  AppStrings.resentOtp,
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                                  : Text(
                                "Resend OTP in 00:${seconds.toString().padLeft(2, '0')}",
                                style: TextStyle(color: Colors.grey),
                              ),

                              AppGaps.h16(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}