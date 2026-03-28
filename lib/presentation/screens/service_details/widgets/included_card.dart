import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// A single card inside the "What's Included" grid.
class IncludedCard extends StatelessWidget {
  const IncludedCard({
    super.key,
    required this.title,
    required this.items,
    required this.bgColor,
    required this.icon,
  });

  final String title;
  final List<String> items;
  final Color bgColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingM),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary, size: AppConstants.iconL),
          const SizedBox(height: AppConstants.paddingS),
          Text(title, style: AppTextStyles.labelBold),
          const SizedBox(height: AppConstants.paddingS),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.paddingXS),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: AppConstants.iconXS,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: AppConstants.paddingXS),
                  Expanded(
                    child: Text(item, style: AppTextStyles.labelSmall),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
