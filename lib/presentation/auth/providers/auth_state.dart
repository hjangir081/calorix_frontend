import 'package:calorix_app/utils/constants/countries.dart';

import '../widgets/phone_input_field.dart';

enum AuthStatus { initial, loading, success, error }

class AuthState {
  final String phoneText;
  final String otpText;
  final CountryCode selectedCountry;
  final AuthStatus status;
  final String? errorMessage;

  const AuthState({
    this.phoneText = '',
    this.otpText = '',
    required this.selectedCountry,
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  AuthState copyWith({
    String? phoneText,
    String? otpText,
    CountryCode? selectedCountry,
    AuthStatus? status,
    String? errorMessage,
  }) {
    return AuthState(
      phoneText: phoneText ?? this.phoneText,
      otpText: otpText ?? this.otpText,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      status: status ?? this.status,
      errorMessage: errorMessage,           // null clears the error
    );
  }
}