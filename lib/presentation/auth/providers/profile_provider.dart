import 'package:calorix_app/presentation/auth/providers/profile_state.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../utils/validators/app_validators.dart';

final profileProvider =
StateNotifierProvider<ProfileNotifier, ProfileState>(
      (ref) => ProfileNotifier(),
);

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(const ProfileState());

  // ─── Update Fields ─────────────────────────────

  void updateFirstName(String value) {
    state = state.copyWith(firstName: value, firstNameError: null);
  }

  void updateLastName(String value) {
    state = state.copyWith(lastName: value, lastNameError: null);
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value, emailError: null);
  }

  void updateDob(String value) {
    state = state.copyWith(dob: value, dobError: null);
  }

  void updateImage(String path) {
    state = state.copyWith(imagePath: path);
  }

  void updateGender(String value) {
    state = state.copyWith(gender: value);
  }

  void updateGoal(String value) {
    state = state.copyWith(goal: value);
  }

  void updateHeight(String value) {
    state = state.copyWith(height: value, heightError: null);
  }

  void updateWeight(String value) {
    state = state.copyWith(weight: value, weightError: null);
  }


  void clearFirstNameError() {
    state = state.copyWith(firstNameError: null);
  }

  void clearLastNameError() {
    state = state.copyWith(lastNameError: null);
  }

  void clearEmailError() {
    state = state.copyWith(emailError: null);
  }

  void clearDobError() {
    state = state.copyWith(dobError: null);
  }

  void clearGenderError() {
    state = state.copyWith(genderError: null);
  }

  void clearHeightError() {
    state = state.copyWith(heightError: null);
  }

  void clearWeightError() {
    state = state.copyWith(weightError: null);
  }

  void clearGoalError() {
    state = state.copyWith(goalError: null);
  }


  /// Returns true if all required fields are valid.
  /// Returns false if required errors exist.
  /// Returns a regex error string separately for snackbar.
  bool validateProfilePage() {
    state = state.copyWith(
      firstNameError: null,
      lastNameError: null,
      emailError: null,
      dobError: null,
      genderError: null,
    );

    bool valid = true;

    if (state.firstName.isEmpty) {
      state = state.copyWith(firstNameError: "First name is required");
      valid = false;
    }
    if (state.lastName.isEmpty) {
      state = state.copyWith(lastNameError: "Last name is required");
      valid = false;
    }
    if (state.email.isEmpty) {
      state = state.copyWith(emailError: "Email is required");
      valid = false;
    }
    if (state.dob == null || state.dob!.isEmpty) {
      state = state.copyWith(dobError: "Date of birth is required");
      valid = false;
    }
    if (state.gender == null || state.gender!.isEmpty) {
      state = state.copyWith(genderError: "Gender is required");
      valid = false;
    }

    return valid;
  }

  bool validateGoalPage() {
    state = state.copyWith(goalError: null);

    if (state.goal == null || state.goal!.isEmpty) {
      state = state.copyWith(goalError: "Goal is required");
      return false;
    }
    return true;
  }

  bool validateHeightPage() {
    state = state.copyWith(heightError: null);

    if (state.height == null || state.height!.isEmpty) {
      state = state.copyWith(heightError: "Height is required");
      return false;
    }
    return true;
  }

  bool validateWeightPage() {
    state = state.copyWith(weightError: null);

    if (state.weight == null || state.weight!.isEmpty) {
      state = state.copyWith(weightError: "Weight is required");
      return false;
    }
    return true;
  }

  String? validateRegex() {
    if (state.firstName.isNotEmpty &&
        AppValidators.name(state.firstName) != null) {
      return "First name should contain only letters";
    }

    if (state.lastName.isNotEmpty &&
        AppValidators.name(state.lastName) != null) {
      return "Last name should contain only letters";
    }

    if (state.email.isNotEmpty &&
        AppValidators.email(state.email) != null) {
      return "Enter valid email";
    }

    return null;
  }
    // ─── Submit Profile API ───────────────────────

  Future<void> submitProfile() async {
    state = state.copyWith(status: ProfileStatus.loading);

    try {
      // 🔥 Call your API here
      // await ApiService.createProfile(...);

      await Future.delayed(const Duration(seconds: 2)); // mock

      state = state.copyWith(status: ProfileStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  // ─── Reset ───────────────────────────────────

  void reset() {
    state = const ProfileState();
  }
}