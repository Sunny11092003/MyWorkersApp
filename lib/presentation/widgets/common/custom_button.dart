import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';

/// Enhanced reusable button with an optional loading state and icon.
///
/// Shows a [CircularProgressIndicator] when [isLoading] is true and disables
/// the press handler automatically.
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = AppColors.white,
    this.width = double.infinity,
    this.borderRadius = AppConstants.radiusXL,
    this.verticalPadding = AppConstants.paddingL,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final double width;
  final double borderRadius;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: isLoading ? _buildLoader() : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (icon == null) {
      return Text(label, style: AppTextStyles.button);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: AppTextStyles.button),
        const SizedBox(width: AppConstants.paddingS),
        Icon(icon, color: AppColors.white, size: AppConstants.iconM),
      ],
    );
  }

  Widget _buildLoader() {
    return const SizedBox(
      height: 22,
      width: 22,
      child: CircularProgressIndicator(
        color: AppColors.white,
        strokeWidth: 2.5,
      ),
    );
  }
}
