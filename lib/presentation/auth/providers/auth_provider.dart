import 'dart:io';
import 'package:calorix_app/domain/models/request/logout_request_model.dart';
import 'package:calorix_app/utils/constants/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../config/di/injector.dart';
import '../../../data/core/data_state.dart';
import '../../../domain/models/request/send_otp_request_model.dart';
import '../../../domain/models/request/verify_otp_request_model.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../domain/repositories/token_storage.dart';
import '../../provider/phone_provider.dart';
import '../widgets/phone_input_field.dart';
import 'auth_state.dart';

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(ref),
);

final repo = getIt<ApiRepository>();

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
      final repo = getIt<ApiRepository>();

      final result = await repo.sendOtp(
        sendOtpRequestModel: SendOtpRequestModel(
          countryCode: country.dialCode,
          phoneNumber: state.phoneText,
        ),
      );

      if (result is DataSuccess) {
        state = state.copyWith(status: AuthStatus.success);
      } else if (result is DataFailed) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: result.exception?.response?.data['message'],
        );
      }
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

    final country = _ref.read(phoneProvider);

    state = state.copyWith(status: AuthStatus.loading);
    String getDeviceType() {
      if (Platform.isAndroid) return "android";
      if (Platform.isIOS) return "ios";
      return "web";
    }
    try {
      final repo = getIt<ApiRepository>();

      final result = await repo.verifyOtp(
        verifyOtpRequestModel: VerifyOtpRequestModel(
          countryCode: country.dialCode,
          phoneNumber: state.phoneText,
          otp: otp,
          deviceType: getDeviceType(),
          fcmToken: "abc123",    // later from Firebase
        ),
      );

      if (result is DataSuccess) {
        final res = result.data;
        final tokenStorage = getIt<TokenStorage>();
        if (res?.result?.accessToken != null) {
          await tokenStorage.saveTokens(
            res!.result!.accessToken!,
            res.result!.refreshToken!,
          );
        }
        if(res?.result?.name != null) {
          await tokenStorage.saveName(res!.result!.name!);
        }
        state = state.copyWith(
          status: AuthStatus.success,
          response: result.data,
          errorMessage: null,
            tempToken: res?.result?.tempToken
        );

        if (res?.result?.isRegistered == true) {
          // Navigate to home
          debugPrint("LOGIN SUCCESS");
        } else {
          // Navigate to complete profile
          debugPrint("NEW USER → COMPLETE PROFILE");
        }

      } else if (result is DataFailed) {
        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage: result.exception?.response?.data['Errors']?[0]?['Message'],
        );
      }

    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.toString(),
      );
    }
  }


// ─── Logout User API ──────────────────────────────────
  Future<void> logout() async {

    state = state.copyWith(
      status: AuthStatus.loading,
    );

    try {

      final tokenStorage =
      getIt<TokenStorage>();

      final token =
      await tokenStorage
          .getAccessToken();

      final repo =
      getIt<ApiRepository>();

      final result =
      await repo.logout(
        token: 'Bearer $token',
        logoutRequestModel: LogoutRequestModel(
          deviceType: Platform.isAndroid
              ? "android"
              : Platform.isIOS
              ? "ios"
              : "web",
        )
      );

      if (result is DataSuccess) {

        await tokenStorage.clear();

        state = state.copyWith(
          status: AuthStatus.initial,
          response: null,
          errorMessage: null,
          otpText: '',
          phoneText: '',
          tempToken: null,
        );

      } else if (
      result is DataFailed) {

        state = state.copyWith(
          status: AuthStatus.error,
          errorMessage:
          result.exception
              ?.response
              ?.data['Errors']?[0]
          ?['Message'],
        );
      }

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