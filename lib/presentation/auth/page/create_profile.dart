import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:calorix_app/presentation/auth/page/goal_page.dart';
import 'package:calorix_app/presentation/auth/widgets/app_gaps.dart';
import 'package:calorix_app/presentation/auth/widgets/app_padding.dart';
import 'package:calorix_app/utils/design/app_media_query.dart';
import 'package:calorix_app/utils/services/app_loader.dart';
import 'package:calorix_app/utils/services/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../utils/constants/app_images.dart';
import '../../../utils/constants/app_strings.dart';
import '../../../utils/design/app_colors.dart';
import '../../../utils/design/app_text.dart';
import '../../../utils/services/image_service.dart';
import '../../../utils/validators/app_validators.dart';
import '../providers/profile_provider.dart';
import '../providers/profile_state.dart';
import '../widgets/app_button.dart';
import '../widgets/app_textField.dart';

@RoutePage()
class CreateProfilePage extends ConsumerWidget {
  const CreateProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    ref.listen(profileProvider, (prev, next) {
      if (next.status == ProfileStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage ?? 'Something went wrong')),
        );
      }

      if (prev?.status != ProfileStatus.success &&
          next.status == ProfileStatus.success) {
        context.router.push(WeightRoute());
      }
    });

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return LoaderOverlay(
        isLoading: profileState.status == ProfileStatus.loading,
        child: Scaffold(
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
                  children: [
                    AppGaps.h(context, 50),
                    GestureDetector(
                      onTap: () {
                        _showImagePicker(context, notifier);
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: AppMediaQuery.width(context)*.28,
                            height: AppMediaQuery.width(context)*.28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.textSecondary.withOpacity(.20),
                              image: profileState.imagePath != null
                                  ? DecorationImage(
                                image: FileImage(
                                  File(profileState.imagePath!),
                                ),
                                fit: BoxFit.cover,
                              )
                                  : null,
                            ),
                            child: profileState.imagePath == null
                                ? const Icon(Icons.person, size: 50)
                                : null,
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.surface,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    AppGaps.h24(context),
                    AppTextField(
                      label: AppFieldsStrings.firstNameField,
                      hint: AppFieldsStrings.enterFirstName,
                      prefixIcon: AppImages.user,
                      errorText: profileState.firstNameError,
                      validator: (val) => AppValidators.name(val, field: "First Name"),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      onChanged: (val){
                        notifier.updateFirstName(val);
                        if (profileState.firstNameError != null) {
                          notifier.clearFirstNameError();
                        }
                      },
                    ),
                    AppGaps.h16(context),
                    AppTextField(
                      label: AppFieldsStrings.lastNameField,
                      hint: AppFieldsStrings.enterLastName,
                      prefixIcon: AppImages.user,
                      errorText: profileState.lastNameError,
                      validator: (val) => AppValidators.name(val, field: "Last Name"),
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      ],
                      onChanged: (val){
                        notifier.updateLastName(val);
                        if (profileState.lastNameError != null) {
                          notifier.clearLastNameError();
                        }
                      },
                    ),
                    AppGaps.h16(context),
                    AppTextField(
                      label: AppFieldsStrings.emailField,
                      hint: AppFieldsStrings.enterEmail,
                      keyboardType: TextInputType.emailAddress,
                      errorText: profileState.emailError,
                      validator: AppValidators.email,
                      prefixIcon: AppImages.mail,
                      onChanged: (val) {
                        notifier.updateEmail(val);
                        if (profileState.emailError != null) {
                          notifier.clearEmailError();
                        }
                      },
                    ),
                    AppGaps.h16(context),
                    GestureDetector(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: AppColors.primaryColor,
                                  onPrimary: AppColors.background,
                                  onSurface: AppColors.background,
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    foregroundColor: AppColors.background,
                                  ),
                                ),
                                dialogBackgroundColor: AppColors.background,
                              ),
                              child: child!,
                            );
                          },
                        );

                        if (pickedDate != null) {
                          final formatted =
                              "${pickedDate.year}/${pickedDate.month}/${pickedDate.day}";
                          notifier.updateDob(formatted);
                        }
                      },
                      child: AbsorbPointer(
                        child: AppTextField(
                          errorText: profileState.dobError,
                          label: AppFieldsStrings.dobField,
                          hint: AppFieldsStrings.dateOfBirth,
                          prefixIcon: AppImages.calendar,
                          controller: TextEditingController(
                            text: profileState.dob ?? '',
                          ),
                        ),
                      ),
                    ),
                    AppGaps.h16(context),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppFieldsStrings.genderField,
                        style: AppQuicksandText.bodyLarge(context, color: AppColors.white)
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    AppGaps.h8(context),
                    Row(
                      children: [
                        _buildGenderOption(context, "Male", profileState.gender, notifier),
                        const SizedBox(width: 12),
                        _buildGenderOption(context, "Female", profileState.gender, notifier),
                        const SizedBox(width: 12),
                        _buildGenderOption(context, "Other", profileState.gender, notifier),
                      ],
                    ),
                    if (profileState.genderError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            profileState.genderError!,
                            style: const TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        )
                      ),
                  ],
                ),
              ),
            ),
          ),

          bottomNavigationBar: SafeArea(
            child: AppPadding(
              child: AppButton(
                text: AppBtnStrings.continueBtn,
                  onPressed: () {
                    final requiredValid = notifier.validateProfilePage();
                    final regexError = notifier.validateRegex();

                    if (!requiredValid) return;

                    if (regexError != null) {
                      AppTopSnackbar.show(
                        context,
                        regexError,
                        type: SnackbarType.error,
                      );
                      return;
                    }

                    context.router.push(WeightRoute());
                  }
                    ),
            ),
          ),
        )
    );
  }
}

Widget _buildGenderOption(BuildContext context, String label,
    String? selectedValue, ProfileNotifier notifier) {
  final isSelected = selectedValue == label;
  return GestureDetector(
    onTap: () {
      notifier.updateGender(label);
      if (selectedValue != null) notifier.clearGenderError();
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppColors.divider : AppColors.textSecondary,
          width: isSelected ? 2 : 1,
        ),
        color: isSelected
            ? AppColors.primaryColor.withOpacity(0.1)
            : AppColors.card,
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primaryColor : AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}


void _showImagePicker(BuildContext context, ProfileNotifier notifier) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Select Image",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// 📷 Camera
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);

                final file = await ImageService.pickFromCamera();
                if (file != null) {
                  notifier.updateImage(file.path);
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);

                final file = await ImageService.pickFromGallery();
                if (file != null) {
                  notifier.updateImage(file.path);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}