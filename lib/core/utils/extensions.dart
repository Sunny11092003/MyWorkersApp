import 'package:flutter/material.dart';

/// Convenience extensions used throughout MyWorkersApp.

extension StringExtension on String {
  /// Capitalizes the first letter of the string.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Returns true if the string is a valid email address.
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return emailRegex.hasMatch(trim());
  }

  /// Formats a price string: prefixes with '$' if not already present.
  String get asPrice {
    if (startsWith('\$')) return this;
    return '\$$this';
  }
}

extension DoubleExtension on double {
  /// Formats a double value as a currency string (e.g. 149.0 → '$149.00').
  String get asCurrencyString {
    return '\$${toStringAsFixed(2)}';
  }
}

extension BuildContextExtension on BuildContext {
  /// Returns the screen width.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the screen height.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns true if the screen width is considered a tablet (≥ 600 dp).
  bool get isTablet => MediaQuery.of(this).size.width >= 600;

  /// Returns the current theme's [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the current theme's [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ColorExtension on Color {
  /// Returns this color with [opacity] applied (0.0–1.0).
  Color withOpacityValue(double opacity) => withValues(alpha: opacity);
}
