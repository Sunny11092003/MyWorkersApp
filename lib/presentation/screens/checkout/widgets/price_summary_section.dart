import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// Displays the itemized price breakdown for the checkout inside a premium
/// dark-gradient card with a prominent total row.
class PriceSummarySection extends StatelessWidget {
  const PriceSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingXXL),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.darkGradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header – white on dark background.
          Row(
            children: [
              const Icon(
                Icons.receipt_long_rounded,
                color: AppColors.white,
                size: AppConstants.iconM,
              ),
              const SizedBox(width: AppConstants.paddingS),
              Text(
                AppStrings.checkoutPriceSummary,
                style: AppTextStyles.checkoutSectionTitle.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.paddingXXL),

          // Line items.
          _DarkSummaryRow(
            label: AppStrings.checkoutServiceFee,
            value: AppStrings.checkoutServiceFeeValue,
          ),
          const SizedBox(height: AppConstants.paddingM),
          _DarkSummaryRow(
            label: AppStrings.checkoutTravelFee,
            value: AppStrings.checkoutTravelFeeValue,
          ),
          const SizedBox(height: AppConstants.paddingM),
          _DarkSummaryRow(
            label: AppStrings.checkoutDiscount,
            value: AppStrings.checkoutDiscountValue,
            isDiscount: true,
          ),

          // Gradient divider.
          const SizedBox(height: AppConstants.paddingL),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.white.withValues(alpha: 0.0),
                  AppColors.white.withValues(alpha: 0.25),
                  AppColors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.paddingL),

          // Prominent total row.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                AppStrings.checkoutTotal,
                style: AppTextStyles.checkoutTotal.copyWith(
                  color: AppColors.white.withValues(alpha: 0.75),
                  fontWeight: FontWeight.w500,
                ),
              ),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: AppColors.goldGradientColors,
                ).createShader(bounds),
                child: Text(
                  AppStrings.checkoutTotalValue,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A single row in the dark-themed price summary table.
class _DarkSummaryRow extends StatelessWidget {
  const _DarkSummaryRow({
    required this.label,
    required this.value,
    this.isDiscount = false,
  });

  final String label;
  final String value;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.checkoutSummaryLabel.copyWith(
            color: AppColors.white.withValues(alpha: 0.65),
          ),
        ),
        Text(
          value,
          style: AppTextStyles.checkoutSummaryValue.copyWith(
            color: isDiscount
                ? AppColors.discountLight
                : AppColors.white,
          ),
        ),
      ],
    );
  }
}
