import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// Displays the itemized price breakdown for the checkout.
class PriceSummarySection extends StatelessWidget {
  const PriceSummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        color: AppColors.checkoutSummaryBg,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.checkoutPriceSummary,
            style: AppTextStyles.checkoutSectionTitle,
          ),
          const SizedBox(height: AppConstants.paddingM),
          _SummaryRow(
            label: AppStrings.checkoutServiceFee,
            value: AppStrings.checkoutServiceFeeValue,
          ),
          const SizedBox(height: AppConstants.paddingS),
          _SummaryRow(
            label: AppStrings.checkoutTravelFee,
            value: AppStrings.checkoutTravelFeeValue,
          ),
          const SizedBox(height: AppConstants.paddingS),
          _SummaryRow(
            label: AppStrings.checkoutDiscount,
            value: AppStrings.checkoutDiscountValue,
            isDiscount: true,
          ),
          const SizedBox(height: AppConstants.paddingM),
          Container(height: 1, color: AppColors.checkoutDivider),
          const SizedBox(height: AppConstants.paddingM),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.checkoutTotal, style: AppTextStyles.checkoutTotal),
              Text(
                AppStrings.checkoutTotalValue,
                style: AppTextStyles.checkoutTotalValue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A single row in the price summary table.
class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
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
        Text(label, style: AppTextStyles.checkoutSummaryLabel),
        Text(
          value,
          style: isDiscount
              ? AppTextStyles.checkoutSummaryValue.copyWith(
                  color: AppColors.accent,
                )
              : AppTextStyles.checkoutSummaryValue,
        ),
      ],
    );
  }
}
