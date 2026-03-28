import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// A single address entry showing an icon, title, and subtitle.
///
/// When selected, the card uses a gradient border and a tinted background
/// for a premium glass-morphism feel.
class AddressItem extends StatelessWidget {
  const AddressItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

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
          // Subtle tinted background when selected.
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grey300,
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
            // Gradient icon container when selected; plain tint otherwise.
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.all(AppConstants.paddingS),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                        colors: AppColors.primaryGradientColors,
                      )
                    : null,
                color: isSelected ? null : AppColors.checkoutAddressIcon,
                borderRadius:
                    BorderRadius.circular(AppConstants.radiusS),
              ),
              child: Icon(
                icon,
                size: AppConstants.iconM,
                color: isSelected ? AppColors.white : AppColors.primary,
              ),
            ),
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.checkoutAddressTitle),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.checkoutAddressBody,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: isSelected
                  ? ShaderMask(
                      key: const ValueKey('check'),
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: AppColors.primaryGradientColors,
                      ).createShader(bounds),
                      child: const Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.white,
                        size: AppConstants.iconM,
                      ),
                    )
                  : const SizedBox.shrink(key: ValueKey('empty')),
            ),
          ],
        ),
      ),
    );
  }
}
