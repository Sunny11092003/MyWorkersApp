import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// Card that displays the service selected by the user before checkout.
class SelectedServiceCard extends StatelessWidget {
  const SelectedServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
            child: Image.asset(
              AppAssets.deepCleaning,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppConstants.paddingL),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.detailedServiceTitle,
                  style: AppTextStyles.checkoutServiceName,
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: AppConstants.iconS,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppConstants.paddingXS),
                    Text(
                      AppStrings.checkoutServiceDuration,
                      style: AppTextStyles.checkoutServiceSubtitle,
                    ),
                    const SizedBox(width: AppConstants.paddingM),
                    const Icon(
                      Icons.star,
                      size: AppConstants.iconS,
                      color: AppColors.ratingIcon,
                    ),
                    const SizedBox(width: AppConstants.paddingXS),
                    Text(
                      AppStrings.checkoutServiceRating,
                      style: AppTextStyles.checkoutServiceSubtitle,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Text(
                  AppStrings.checkoutServiceFeeValue,
                  style: AppTextStyles.checkoutServiceName.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
