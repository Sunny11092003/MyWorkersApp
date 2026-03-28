/// String utility extensions for MyWorkersApp.
extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Converts a snake_case or kebab-case string to Title Case.
  String get toTitleCase {
    return split(RegExp(r'[_\-\s]'))
        .map((w) => w.isEmpty ? w : w.capitalize)
        .join(' ');
  }

  /// Returns true if the string is a valid email address.
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(trim());
  }

  /// Returns true if the string contains only digits.
  bool get isNumeric => RegExp(r'^\d+$').hasMatch(this);

  /// Formats a price string: prefixes with '\$' if not already present.
  String get asPrice {
    if (startsWith('\$')) return this;
    return '\$$this';
  }

  /// Truncates the string to [maxLength] characters and appends '…' if needed.
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}…';
  }
}
