/// Number utility extensions for MyWorkersApp.
extension IntExtension on int {
  /// Formats an integer as a currency string (e.g. 149 → '$149.00').
  String get asCurrencyString => '\$${toDouble().toStringAsFixed(2)}';

  /// Returns whether the integer is in the inclusive range [min, max].
  bool isBetween(int min, int max) => this >= min && this <= max;
}

extension DoubleExtension on double {
  /// Formats a double value as a currency string (e.g. 149.0 → '$149.00').
  String get asCurrencyString => '\$${toStringAsFixed(2)}';

  /// Clamps the value between 0.0 and 1.0.
  double get clamped => clamp(0.0, 1.0);

  /// Converts a value in logical pixels to an approximate sp (same value in
  /// this context – kept for semantic clarity).
  double get sp => this;
}

extension NumExtension on num {
  /// Returns whether this number is strictly positive.
  bool get isPositive => this > 0;

  /// Returns whether this number is zero.
  bool get isZero => this == 0;
}
