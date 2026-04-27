import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/utils/constants/app_images.dart';
import 'package:calorix_app/utils/constants/app_strings.dart';
import 'package:calorix_app/utils/design/app_text.dart';
import 'package:calorix_app/utils/services/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/router/app_router.gr.dart';
import '../../../utils/design/app_media_query.dart';
import '../../../utils/design/app_responsive.dart';
import '../../../utils/services/app_loader.dart';
import '../../../utils/validators/app_validators.dart';
import '../../provider/phone_provider.dart';
import '../../widgets/sliding_btn.dart';
import '../providers/auth_provider.dart';
import '../providers/auth_state.dart';
import '../widgets/app_button.dart';
import '../widgets/app_gaps.dart';
import '../widgets/app_padding.dart';
import '../widgets/app_textField.dart';
import '../widgets/phone_input_field.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final selectedCountry = ref.watch(phoneProvider);
    final notifier = ref.read(authProvider.notifier);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
    ref.listen(authProvider, (prev, next) {
      if (prev?.status != AuthStatus.success &&
          next.status == AuthStatus.success) {
        context.router.push(OtpRoute());
      }

      if (next.status == AuthStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage ?? 'Something went wrong')),
        );
        notifier.reset();
      }
    });
    return LoaderOverlay(
      isLoading: authState.status == AuthStatus.loading,
      child: Scaffold(
        bottomNavigationBar: SafeArea(
          child: SingleChildScrollView(
            child: AppPadding(
              child: AppButton(
                text: AppBtnStrings.sendOtp,
                onPressed: () {
                  final error = AppValidators.phoneGlobal(
                    authState.phoneText,
                    countryCode: selectedCountry.dialCode,
                    minLength: selectedCountry.minLength,
                    maxLength: selectedCountry.maxLength,
                  );

                  if (error != null) {
                    AppTopSnackbar.show(
                      context,
                      error,
                      type: SnackbarType.error,
                    );
                    return;
                  }
                  notifier.sendOtp();
                },
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(AppImages.loginBg, fit: BoxFit.cover),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(
                  bottom: AppMediaQuery.height(context) * .2,
                  top: AppMediaQuery.height(context) * .02,
                ),
                constraints: BoxConstraints(
                  maxHeight: AppResponsive.bottomSheetLarge(context),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                            AppStrings.login,
                            style: AppQuicksandText.display(
                              context,
                            ).copyWith(fontWeight: FontWeight.bold),
                          ),
                          AppGaps.h16(context),
                          PhoneInputField(
                            onChanged: (val) => notifier.updatePhone(val),
                            hintText: 'Enter your mobile number',
                            validator: (value) {
                              return AppValidators.phoneGlobal(
                                value,
                                countryCode: selectedCountry.dialCode,
                                minLength: selectedCountry.minLength,
                                maxLength: selectedCountry.maxLength,
                              );
                            },
                          ),
                          AppGaps.h16(context),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
