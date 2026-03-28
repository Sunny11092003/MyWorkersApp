import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// Premium card that displays the service selected by the user before checkout.
///
/// Features a gradient-overlaid image thumbnail, PREMIUM badge, service name,
/// duration, star rating and price – all inside a glass-morphism styled card.
class SelectedServiceCard extends StatelessWidget {
  const SelectedServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.10),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Thumbnail with gradient overlay ──────────────────────────
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppConstants.radiusM),
                child: Image.asset(
                  AppAssets.deepCleaning,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              // Gradient overlay for premium feel.
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppConstants.radiusM),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.transparent,
                        AppColors.primary.withValues(alpha: 0.30),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: AppConstants.paddingL),

          // ── Service details ───────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PREMIUM badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingS,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.premiumBadgeColor,
                    borderRadius:
                        BorderRadius.circular(AppConstants.radiusS),
                  ),
                  child: Text(
                    AppStrings.detailedPremiumBadge,
                    style: AppTextStyles.labelCaps.copyWith(
                      color: AppColors.white,
                      fontSize: 9,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Text(
                  AppStrings.detailedServiceTitle,
                  style: AppTextStyles.checkoutServiceName,
                ),
                const SizedBox(height: AppConstants.paddingXS),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
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
                      Icons.star_rounded,
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
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: AppColors.primaryGradientColors,
                  ).createShader(bounds),
                  child: Text(
                    AppStrings.checkoutServiceFeeValue,
                    style: AppTextStyles.checkoutServiceName.copyWith(
                      color: AppColors.white,
                    ),
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
