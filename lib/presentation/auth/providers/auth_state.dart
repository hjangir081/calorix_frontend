import '../widgets/phone_input_field.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState {
  final String phoneText;
  final String otpText;
  final CountryCode selectedCountry;
  final AuthStatus status;
  final String? errorMessage;
  final dynamic response;
  final String? tempToken;
  final String? fcmToken;

  const AuthState({
    this.phoneText = '',
    this.otpText = '',
    required this.selectedCountry,
    this.status = AuthStatus.initial,
    this.errorMessage,
    this.response,
    this.tempToken,
    this.fcmToken,
  });

  AuthState copyWith({
    String? phoneText,
    String? otpText,
    CountryCode? selectedCountry,
    AuthStatus? status,
    String? errorMessage,
    dynamic response,
    String? tempToken,
    String? fcmToken,
  }) {
    return AuthState(
      phoneText: phoneText ?? this.phoneText,
      otpText: otpText ?? this.otpText,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      status: status ?? this.status,
      errorMessage: errorMessage,
      response: response ?? this.response,
      tempToken: tempToken ?? this.tempToken,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }
}