import 'package:get/get.dart';

typedef Validator = String? Function(String? value);

/// Required field
String? requiredValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'This field is required'.tr;
  return null;
}

/// Minimum length factory
Validator minLengthValidator(int min, {String? message}) {
  return (String? v) {
    if (v == null || v.length < min) {
      return message ??
          'Characters must be at least @min'.trParams({'min': min.toString()});
    }
    return null;
  };
}

/// Maximum length factory
Validator maxLengthValidator(int max, {String? message}) {
  return (String? v) {
    if (v != null && v.length > max) {
      return message ??
          'Characters must be at most @max'.trParams({'max': max.toString()});
    }
    return null;
  };
}

/// Alphanumeric username (letters, numbers, underscores, dots)
String? usernameValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Username is required'.tr;
  final regex = RegExp(r'^[a-zA-Z0-9._]+$');
  if (!regex.hasMatch(v))
    return 'Only letters, numbers, dot and underscore allowed'.tr;
  if (v.length < 3 || v.length > 30)
    return 'Username must be 3–30 characters'.tr;
  return null;
}

/// Simple email validator
String? emailValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Email is required'.tr;
  // RFC-complete regex is huge; this is pragmatic and common
  final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  if (!regex.hasMatch(v.trim())) return 'Enter a valid email'.tr;
  return null;
}

/// Strong password check (factory): customizable rules
Validator passwordValidatorFactory({
  int minLength = 8,
  bool requireUpper = false,
  bool requireLower = false,
  bool requireDigits = false,
  bool requireSpecial = false,
  String? message,
}) {
  return (String? v) {
    if (v == null || v.isEmpty) return 'Password is required'.tr;
    if (v.length < minLength)
      return message ??
          'Password must be at least @minLength characters'.trParams({
            'minLength': minLength.toString(),
          });
    if (requireUpper && !RegExp(r'[A-Z]').hasMatch(v))
      return 'Password must contain an uppercase letter'.tr;
    if (requireLower && !RegExp(r'[a-z]').hasMatch(v))
      return 'Password must contain a lowercase letter'.tr;
    if (requireDigits && !RegExp(r'\d').hasMatch(v))
      return 'Password must contain a digit'.tr;
    if (requireSpecial &&
        !RegExp(r'''[!@#\$&*~^%()_\-+=\[\]{}|\\;:'",.<>/?]''').hasMatch(v)) {
      return 'Password must contain a special character'.tr;
    }
    return null;
  };
}

/// Confirm password: pass reference to password getter (controller.text)
Validator confirmPasswordValidator(
  String Function() getPassword, {
  String? message,
}) {
  return (String? v) {
    if (v == null) return message ?? 'Passwords do not match'.tr;
    if (v != getPassword()) return message ?? 'Passwords do not match'.tr;
    return null;
  };
}

String? phoneRequiredValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Phone number is required'.tr;
  // very generic numeric check; for country-specific use libphonenumber
  final digits = v.replaceAll(RegExp(r'\D'), '');
  if (digits.length < 7) return 'Enter a valid phone number'.tr;
  return null;
}

String? numericValidator(String? v) {
  if (v == null || v.isEmpty) return null; // allow empty if optional
  if (!RegExp(r'^\d+$').hasMatch(v)) return 'Must be numeric'.tr;
  return null;
}

String? urlValidator(String? v) {
  if (v == null || v.trim().isEmpty) return null;
  final regex = RegExp(r'^(https?:\/\/)?([\w-]+\.)+[\w-]{2,}\/?.*$');
  if (!regex.hasMatch(v.trim())) return 'Enter a valid URL'.tr;
  return null;
}

/// Validates positive numbers (doubles)
String? positiveNumberValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'This field is required'.tr;
  final number = double.tryParse(v.trim());
  if (number == null) return 'Please enter a valid number'.tr;
  if (number <= 0) return 'Value must be greater than 0'.tr;
  return null;
}

/// Validates stock symbol format
String? stockSymbolValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Stock symbol is required'.tr;
  final regex = RegExp(r'^[A-Z]{1,5}$');
  if (!regex.hasMatch(v.trim().toUpperCase())) {
    return 'Symbol must be 1-5 uppercase letters'.tr;
  }
  return null;
}

/// Validates option type (CALL or PUT)
String? optionTypeValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Option type is required'.tr;
  final type = v.trim().toUpperCase();
  if (type != 'CALL' && type != 'PUT') {
    return 'Type must be CALL or PUT'.tr;
  }
  return null;
}

/// Validates strike price
String? strikePriceValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Strike price is required'.tr;
  final number = double.tryParse(v.trim());
  if (number == null) return 'Please enter a valid strike price'.tr;
  if (number <= 0) return 'Strike price must be greater than 0'.tr;
  return null;
}

/// Validates option premium (entry/target prices)
String? optionPremiumValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Premium is required'.tr;
  final number = double.tryParse(v.trim());
  if (number == null) return 'Please enter a valid premium'.tr;
  if (number <= 0) return 'Premium must be greater than 0'.tr;
  return null;
}

/// Validates expiry date
String? expiryDateValidator(DateTime? date) {
  if (date == null) return 'Expiry date is required'.tr;
  if (date.isBefore(DateTime.now())) {
    return 'Expiry date cannot be in the past'.tr;
  }
  return null;
}

/// Validates date range for archive filters
String? dateRangeValidator(DateTime? startDate, DateTime? endDate) {
  if (startDate != null && endDate != null) {
    if (startDate.isAfter(endDate)) {
      return 'Start date must be before end date'.tr;
    }
  }
  return null;
}

/// Validates symbol search input (optional)
String? symbolSearchValidator(String? v) {
  if (v == null || v.trim().isEmpty) return null; // Optional field
  if (v.trim().length > 10) return 'Symbol too long'.tr;
  return null;
}

/// Validates phone number with international format
String? phoneNumberValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'Phone number is required'.tr;
  // Remove all non-digit characters
  String digits = v.replaceAll(RegExp(r'\D'), '');

  // Check if it starts with + and country code
  if (!v.startsWith('+')) {
    return 'Phone number must start with country code (+)'.tr;
  }

  // Remove the + for digit counting
  digits = v.substring(1).replaceAll(RegExp(r'\D'), '');

  // Basic length check (7-15 digits is international standard)
  if (digits.length < 7 || digits.length > 15) {
    return 'Enter a valid phone number'.tr;
  }

  return null;
}

/// Validates OTP code
String? otpValidator(String? v) {
  if (v == null || v.trim().isEmpty) return 'OTP is required'.tr;
  // Remove all non-digit characters
  String digits = v.replaceAll(RegExp(r'\D'), '');

  // OTP should be 6 digits
  if (digits.length != 6) {
    return 'OTP must be 6 digits'.tr;
  }

  return null;
}
