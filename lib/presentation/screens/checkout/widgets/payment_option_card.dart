import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// A card representing a single payment option (e.g. card, cash, wallet).
///
/// Highlights with a colored border and background when [isSelected].
class PaymentOptionCard extends StatelessWidget {
  const PaymentOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
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
            color: isSelected
                ? AppColors.checkoutPaymentBorder
                : AppColors.grey300,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: AppConstants.paddingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.checkoutPaymentLabel),
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
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }
}
