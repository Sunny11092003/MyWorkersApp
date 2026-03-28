import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// Hero card displayed at the top of the service details screen.
///
/// Shows the service image, a gradient overlay, a premium badge and a
/// title overlay.
class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.imageAssetPath,
    this.title = AppStrings.detailedHeroTitle,
    this.isPremium = true,
  });

  final String imageAssetPath;
  final String title;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppConstants.radiusHero),
      child: Stack(
        children: [
          _buildImage(),
          _buildGradientOverlay(),
          if (isPremium) _buildPremiumBadge(),
          _buildTitleOverlay(title),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      height: AppConstants.heroCardHeight,
      width: double.infinity,
      color: Colors.grey[300],
      child: Image.asset(
        imageAssetPath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey[300],
          child: const Center(child: Icon(Icons.image, size: 48)),
        ),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      height: AppConstants.heroCardHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.heroBannerGradient,
        ),
      ),
    );
  }

  Widget _buildPremiumBadge() {
    return Positioned(
      top: AppConstants.paddingL,
      left: AppConstants.paddingL,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingM,
          vertical: AppConstants.paddingXS + 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppConstants.radiusBadge),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star,
              color: AppColors.white,
              size: AppConstants.iconS,
            ),
            const SizedBox(width: AppConstants.paddingXS),
            Text(
              AppStrings.detailedPremiumBadge,
              style: AppTextStyles.premiumBadge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleOverlay(String title) {
    return Positioned(
      bottom: AppConstants.paddingL,
      left: AppConstants.paddingL,
      right: AppConstants.paddingL,
      child: Text(title, style: AppTextStyles.heading2),
    );
  }
}
