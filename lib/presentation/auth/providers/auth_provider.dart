import 'package:calorix_app/utils/constants/countries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../provider/phone_provider.dart';
import '../widgets/phone_input_field.dart';
import 'auth_state.dart';

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(ref),
);


class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;
  AuthNotifier(this._ref)
      : super(
    AuthState(
      selectedCountry: countries.firstWhere(
            (c) => c.code == 'IN',
        orElse: () => countries.first,
      ),
    ),
  );

  // ─── Phone ───────────────────────────────────────────
  void updatePhone(String value) {
    state = state.copyWith(phoneText: value);
  }

  // ─── Country ─────────────────────────────────────────
  void updateCountry(CountryCode country) {
    state = state.copyWith(selectedCountry: country);
  }

  // ─── OTP ─────────────────────────────────────────
  void updateOtp(String value) {
    state = state.copyWith(otpText: value);
  }

  // ─── Send OTP API ────────────────────────────────────
  Future<void> sendOtp() async {
    final country = _ref.read(phoneProvider);
    state = state.copyWith(status: AuthStatus.loading);
    try {
      // await ApiService.sendOtp(
      //   phone: state.phoneText,
      //   dialCode: country.dialCode,
      // );
      // ✅ don't set success until API is real
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

// ─── Verify OTP API ──────────────────────────────────
  Future<void> verifyOtp(String otp) async {
    if (otp.length < 4) return;
    state = state.copyWith(status: AuthStatus.loading);
    try {
      // await ApiService.verifyOtp(otp: otp);
      // ✅ don't set success until API is real
      state = state.copyWith(status: AuthStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }


  // ─── Reset ───────────────────────────────────────────
  void reset() {
    state = state.copyWith(
      status: AuthStatus.initial,
      errorMessage: null,
    );
  }
}