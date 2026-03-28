import 'package:flutter/material.dart';

/// [BuildContext] utility extensions for MyWorkersApp.
extension BuildContextExtension on BuildContext {
  // ── Screen dimensions ────────────────────────────────────────────────────

  /// Returns the screen width in logical pixels.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns the screen height in logical pixels.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns true when the screen width is ≥ 600 dp (tablet breakpoint).
  bool get isTablet => screenWidth >= 600;

  // ── Theme shortcuts ──────────────────────────────────────────────────────

  /// Returns the current theme's [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the current theme's [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  // ── Navigation shortcuts ─────────────────────────────────────────────────

  /// Pops the current route.
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// Pushes a named route.
  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
}
