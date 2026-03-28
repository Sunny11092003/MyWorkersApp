import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// Reusable premium section header used across checkout section widgets.
///
/// Displays a gradient left-accent bar, an optional leading [icon], and a
/// [title] text styled as [AppTextStyles.checkoutSectionTitle].
class PremiumSectionHeader extends StatelessWidget {
  const PremiumSectionHeader(
    this.title, {
    super.key,
    this.icon,
  });

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Vertical gradient accent bar.
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryGradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: AppConstants.paddingS),
        if (icon != null) ...[
          Icon(icon, size: AppConstants.iconM, color: AppColors.primary),
          const SizedBox(width: AppConstants.paddingXS),
        ],
        Text(title, style: AppTextStyles.checkoutSectionTitle),
      ],
    );
  }
}
