class AppValidators {
  static String? required(String? value, {String field = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$field is required";
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex =
    RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');

    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }

    final usernameRegex =
    RegExp(r'^[a-zA-Z][a-zA-Z0-9._]{2,19}$');

    if (!usernameRegex.hasMatch(value)) {
      return "Username must start with a letter and be 3–20 characters (letters, numbers, . or _)";
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    if (value.length != 10) {
      return "Enter valid 10-digit number";
    }

    return null;
  }

  static String? otp(String? value) {
    if (value == null || value.isEmpty) {
      return "OTP is required";
    }

    if (value.length != 4) {
      return "Enter valid OTP";
    }

    return null;
  }

  static String? name(String? value, {String field = "Field"}) {
    if (value == null || value.trim().isEmpty) {
      return "$field is required";
    }

    final regex = RegExp(r'^[a-zA-Z]{2,30}$');

    if (!regex.hasMatch(value)) {
      return "$field must contain only letters (no spaces)";
    }

    return null;
  }

  /// Global phone number validation with country-specific rules
  /// [value] - The phone number (without country code)
  /// [countryCode] - The country dial code (e.g., '+91', '+1', '+44')
  /// [minLength] - Minimum length for the phone number
  /// [maxLength] - Maximum length for the phone number
  static String? phoneWithCountryCode(
      String? value, {
        String? countryCode,
        int? minLength,
        int? maxLength,
      }) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    // Remove any non-digit characters
    final cleanNumber = value.replaceAll(RegExp(r'\D'), '');

    // Check if number contains only digits
    if (cleanNumber.length != value.length) {
      return "Phone number must contain only digits";
    }

    // Validate based on length constraints
    if (minLength != null && cleanNumber.length < minLength) {
      return "Phone number must be at least $minLength digits";
    }

    if (maxLength != null && cleanNumber.length > maxLength) {
      return "Phone number must not exceed $maxLength digits";
    }

    // Additional country-specific validations
    if (countryCode != null) {
      switch (countryCode) {
        case '+91': // India
          if (cleanNumber.length != 10) {
            return "Enter valid 10-digit Indian phone number";
          }
          if (!RegExp(r'^[6-9]\d{9}$').hasMatch(cleanNumber)) {
            return "Indian mobile numbers must start with 6-9";
          }
          break;

        case '+1': // US/Canada
          if (cleanNumber.length != 10) {
            return "Enter valid 10-digit phone number";
          }
          if (cleanNumber.startsWith('0') || cleanNumber.startsWith('1')) {
            return "Phone number cannot start with 0 or 1";
          }
          break;

        case '+44': // UK
          if (cleanNumber.length < 10 || cleanNumber.length > 10) {
            return "Enter valid UK phone number (10 digits)";
          }
          break;

        case '+61': // Australia
          if (cleanNumber.length != 9) {
            return "Enter valid 9-digit Australian phone number";
          }
          break;

        case '+65': // Singapore
          if (cleanNumber.length != 8) {
            return "Enter valid 8-digit Singapore phone number";
          }
          break;

        case '+971': // UAE
          if (cleanNumber.length != 9) {
            return "Enter valid 9-digit UAE phone number";
          }
          if (!RegExp(r'^5[0-9]{8}$').hasMatch(cleanNumber)) {
            return "UAE mobile numbers must start with 5";
          }
          break;

        case '+86': // China
          if (cleanNumber.length != 11) {
            return "Enter valid 11-digit Chinese phone number";
          }
          if (!cleanNumber.startsWith('1')) {
            return "Chinese mobile numbers must start with 1";
          }
          break;

        default:
        // Generic validation for other countries
          if (cleanNumber.length < 8 || cleanNumber.length > 15) {
            return "Enter valid phone number (8-15 digits)";
          }
      }
    } else {
      // If no country code provided, use generic validation
      if (cleanNumber.length < 8 || cleanNumber.length > 15) {
        return "Enter valid phone number (8-15 digits)";
      }
    }

    return null;
  }

  /// Quick validator for PhoneInputField widget
  /// Automatically extracts country code info from the widget
  static String? phoneGlobal(
      String? value, {
        String? countryCode = '+91',
        int minLength = 10,
        int maxLength = 10,
      }) {
    return phoneWithCountryCode(
      value,
      countryCode: countryCode,
      minLength: minLength,
      maxLength: maxLength,
    );
  }

}