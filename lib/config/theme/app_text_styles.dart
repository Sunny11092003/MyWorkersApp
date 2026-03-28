import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Centralized typography constants for MyWorkersApp.
///
/// All text styles use the Poppins font via [GoogleFonts]. Reference styles
/// from here instead of creating inline [TextStyle] objects.
class AppTextStyles {
  AppTextStyles._();

  // ── Headings ────────────────────────────────────────────────────────────

  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading2 => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );

  static TextStyle get heading3 => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading4 => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  // ── Body ────────────────────────────────────────────────────────────────

  static TextStyle get bodyLarge => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodyMedium => GoogleFonts.poppins(
        fontSize: 14,
        color: AppColors.textPrimary,
        height: 1.6,
      );

  static TextStyle get bodySmall => GoogleFonts.poppins(
        fontSize: 13,
        color: AppColors.grey700,
        height: 1.4,
      );

  // ── Labels ──────────────────────────────────────────────────────────────

  static TextStyle get labelBold => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get labelMuted => GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: AppColors.grey600,
      );

  static TextStyle get labelCaps => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.grey600,
        letterSpacing: 1,
      );

  static TextStyle get labelSmall => GoogleFonts.poppins(
        fontSize: 11,
        color: AppColors.grey700,
      );

  // ── Button ──────────────────────────────────────────────────────────────

  static TextStyle get button => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );

  // ── AppBar ──────────────────────────────────────────────────────────────

  static TextStyle get appBarTitle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // ── Specialised ─────────────────────────────────────────────────────────

  static TextStyle get premiumBadge => GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );

  static TextStyle get estimateTotal => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      );

  static TextStyle get promiseTitle => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );

  static TextStyle get promiseBody => GoogleFonts.poppins(
        fontSize: 13,
        color: AppColors.grey300,
        height: 1.4,
      );
}
