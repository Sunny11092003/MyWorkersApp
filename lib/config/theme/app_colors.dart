import 'package:flutter/material.dart';

/// Centralized color constants for the config layer.
///
/// All colors used in the presentation layer should be referenced from here.
class AppColors {
  AppColors._();

  // Brand primaries
  static const Color primary = Color(0xFF5B5FFF);
  static const Color primaryDark = Color(0xFF1A1E3F);

  // Accent
  static const Color accent = Color(0xFF10B981);

  // Neutrals
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // Grey scale
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);

  // Backgrounds
  static const Color scaffoldBackground = Colors.white;
  static const Color cardBackground = Colors.white;
  static const Color surfaceLight = Color(0xFFF5F5F5);

  // Rating badge
  static const Color ratingBackground = Color(0xFFFEF3C7);
  static const Color ratingIcon = Color(0xFFF59E0B);
  static const Color ratingText = Color(0xFF92400E);

  // Included-card backgrounds
  static const Color cardLivingBg = Color(0xFFE3F2FD);
  static const Color cardKitchenBg = Color(0xFFE0F7F4);
  static const Color cardBathroomBg = Color(0xFFFCE4EC);
  static const Color cardSanitizationBg = Color(0xFFFFF3E0);

  // Text
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);

  // Gradient stops
  static const List<Color> heroBannerGradient = [
    Colors.transparent,
    Color(0x80000000),
  ];
}
