/// Input validation helpers for MyWorkersApp form fields.
class Validators {
  Validators._();

  // ── Email ─────────────────────────────────────────────────────────────────

  /// Returns an error message if [value] is not a valid email, else null.
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

  // ── Phone ─────────────────────────────────────────────────────────────────

  /// Returns an error message if [value] is not a valid phone number, else null.
  ///
  /// Accepts 7–15 digits with an optional leading '+'.
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

  // ── Required ──────────────────────────────────────────────────────────────

  /// Returns an error message if [value] is null or blank, else null.
  static String? validateRequired(
    String? value, {
    String fieldName = 'Field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  // ── Search ────────────────────────────────────────────────────────────────

  /// Returns an error message if [value] has fewer than 2 characters, else null.
  static String? validateSearch(String? value) {
    if (value == null || value.trim().length < 2) {
      return 'Enter at least 2 characters to search.';
    }
    return null;
  }

  // ── Password ──────────────────────────────────────────────────────────────

  /// Returns an error message if [value] has fewer than 8 characters, else null.
  static String? validatePassword(String? value) {
    if (value == null || value.trim().length < 8) {
      return 'Password must be at least 8 characters.';
    }
    return null;
  }
}
