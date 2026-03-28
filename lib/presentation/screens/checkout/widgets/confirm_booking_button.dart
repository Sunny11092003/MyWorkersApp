import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// Full-width button at the bottom of the checkout screen that triggers booking.
///
/// Shows a loading spinner while [isLoading] is true.
class ConfirmBookingButton extends StatelessWidget {
  const ConfirmBookingButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.paddingXL,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusXL),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  color: AppColors.white,
                  strokeWidth: 2.5,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.checkoutConfirmBooking,
                    style: AppTextStyles.button,
                  ),
                  const SizedBox(width: AppConstants.paddingS),
                  const Icon(
                    Icons.arrow_forward,
                    color: AppColors.white,
                    size: AppConstants.iconM,
                  ),
                ],
              ),
      ),
    );
  }
}
