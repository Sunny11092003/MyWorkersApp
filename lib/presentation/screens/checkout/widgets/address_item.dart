import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// A single address entry showing an icon, title, and subtitle.
///
/// Used inside [ServiceAddressSection] to list saved addresses.
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
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingL,
          vertical: AppConstants.paddingM,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.checkoutSelectedPayment
              : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grey300,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingS),
              decoration: BoxDecoration(
                color: AppColors.checkoutAddressIcon,
                borderRadius: BorderRadius.circular(AppConstants.radiusS),
              ),
              child: Icon(icon, size: AppConstants.iconM, color: AppColors.primary),
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
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.primary,
                size: AppConstants.iconM,
              ),
          ],
        ),
      ),
    );
  }
}
