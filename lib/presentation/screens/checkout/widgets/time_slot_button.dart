import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// A pill-shaped button representing a single time slot option.
///
/// Highlights in the primary brand color when [isSelected] is true.
class TimeSlotButton extends StatelessWidget {
  const TimeSlotButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
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
          vertical: AppConstants.paddingS,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.checkoutUnselectedSlot,
          borderRadius: BorderRadius.circular(AppConstants.radiusPill),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.grey300,
          ),
        ),
        child: Text(
          label,
          style: isSelected
              ? AppTextStyles.checkoutTimeSlotSelected
              : AppTextStyles.checkoutTimeSlot,
        ),
      ),
    );
  }
}
