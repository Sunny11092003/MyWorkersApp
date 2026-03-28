import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// A card representing a single payment option (e.g. card, cash, wallet).
///
/// When [isSelected] the card shows a gradient border and tinted background.
/// An optional [isRecommended] flag renders a green RECOMMENDED badge.
class PaymentOptionCard extends StatelessWidget {
  const PaymentOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    this.isRecommended = false,
  });

  final Widget icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isRecommended;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingL,
          vertical: AppConstants.paddingM,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(
            color: isSelected
                ? AppColors.checkoutPaymentBorder
                : AppColors.grey300,
            width: isSelected ? 1.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.12),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: AppTextStyles.checkoutPaymentLabel,
                        ),
                      ),
                      if (isRecommended) ...[
                        const SizedBox(width: AppConstants.paddingS),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.recommendedBadgeColor,
                            borderRadius:
                                BorderRadius.circular(AppConstants.radiusS),
                          ),
                          child: Text(
                            AppStrings.checkoutPaymentRecommended,
                            style: AppTextStyles.labelCaps.copyWith(
                              color: AppColors.white,
                              fontSize: 8,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: AppTextStyles.labelSmall,
                    ),
                  ],
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? ShaderMask(
                      key: const ValueKey('selected'),
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: AppColors.primaryGradientColors,
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.white,
                        size: AppConstants.iconM,
                      ),
                    )
                  : Icon(
                      key: const ValueKey('unselected'),
                      Icons.radio_button_unchecked,
                      color: AppColors.grey300,
                      size: AppConstants.iconM,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
