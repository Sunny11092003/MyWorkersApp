/// Utility class for validating user inputs throughout the app.
class Validators {
  Validators._();

  /// Validates an email address.
  /// Returns an error message string, or null if valid.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  /// Validates a phone number (basic: 7-15 digits, optional leading +).
  /// Returns an error message string, or null if valid.
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required.';
    }
    final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
    if (!phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid phone number.';
    }
    return null;
  }

  /// Validates a non-empty required text field.
  /// Returns an error message string, or null if valid.
  static String? validateRequired(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  /// Validates a search query (minimum 2 characters).
  /// Returns an error message string, or null if valid.
  static String? validateSearch(String? value) {
    if (value == null || value.trim().length < 2) {
      return 'Enter at least 2 characters to search.';
    }
    return null;
  }
}
