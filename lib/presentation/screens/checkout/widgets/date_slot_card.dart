import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// A card representing a single date slot in the schedule picker.
///
/// When [isSelected] the card shows a gradient background with a shadow for
/// a premium elevated look; otherwise it uses the neutral surface colour.
class DateSlotCard extends StatelessWidget {
  const DateSlotCard({
    super.key,
    required this.dayLabel,
    required this.dateLabel,
    required this.isSelected,
    required this.onTap,
  });

  final String dayLabel;
  final String dateLabel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        width: 56,
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.paddingM,
          horizontal: AppConstants.paddingS,
        ),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: AppColors.primaryGradientColors,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: isSelected ? null : AppColors.checkoutUnselectedSlot,
          borderRadius: BorderRadius.circular(AppConstants.radiusM),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              dayLabel,
              style: isSelected
                  ? AppTextStyles.checkoutSlotDaySelected
                  : AppTextStyles.checkoutSlotDay,
            ),
            const SizedBox(height: AppConstants.paddingXS),
            Text(
              dateLabel,
              style: isSelected
                  ? AppTextStyles.checkoutSlotDateSelected
                  : AppTextStyles.checkoutSlotDate,
            ),
          ],
        ),
      ),
    );
  }
}
