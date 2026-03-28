import 'package:flutter/material.dart';

/// Centralized color constants for MyWorkersApp.
/// All colors used throughout the app should be referenced from here.
class AppColors {
  AppColors._();

  // Primary brand colors
  static const Color primary = Color(0xFF4361EE);
  static const Color primaryLight = Color(0xFF6C63FF);
  static const Color primarySeed = Color(0xFF4361EE);

  // Accent / secondary
  static const Color accent = Color(0xFF10B981);

  // Backgrounds
  static const Color scaffoldBackground = Colors.white;
  static const Color surfaceLight = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;

  // Category chip backgrounds
  static const Color categoryBlue = Color(0xFFBBDEFB);
  static const Color categoryGreen = Color(0xFFC8E6C9);
  static const Color categoryOrange = Color(0xFFFFE0B2);
  static const Color categoryPink = Color(0xFFF8BBD9);
  static const Color categoryPurple = Color(0xFFE1BEE7);
  static const Color categoryAmber = Color(0xFFFFF9C4);

  // Status / tracking
  static const Color trackingBackground = Color(0xFFF0FDF4);
  static const Color trackingBorder = Color(0xFF86EFAC);
  static const Color trackingIcon = Color(0xFF86EFAC);
  static const Color trackingText = Color(0xFF166534);
  static const Color trackingSubtext = Color(0xFF15803D);
  static const Color trackingProgress = Color(0xFF10B981);
  static const Color trackingProgressBg = Color(0xFFBBF7D0);

  // Rating badge
  static const Color ratingBackground = Color(0xFFFEF3C7);
  static const Color ratingIcon = Color(0xFFF59E0B);
  static const Color ratingText = Color(0xFF92400E);

  // Text colors
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDark = Colors.black87;
  static const Color textMuted = Colors.grey;

  // Shadow
  static const Color shadowColor = Colors.grey;

  // Offer gradient
  static const List<Color> offerGradient = [primary, primaryLight];

  // Service banner gradient
  static const List<Color> bannerGradient = [
    Color(0xFF4361EE),
    Color(0xFFB5B0FF),
  ];

  // Featured badge
  static const Color featuredBadge = primary;

  // Filter chip
  static const Color filterChipBackground = Color(0xFFF5F5F5);

  // Booking screen
  static const Color bookingDark = Color(0xFF1A1E3F);
  static const Color bookingPrimary = Color(0xFF5B5FFF);
}
