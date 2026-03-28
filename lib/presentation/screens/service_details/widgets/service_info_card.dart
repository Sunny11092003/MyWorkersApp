import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';

/// A single info item (icon + label + value) used inside [ServiceInfoRow].
class ServiceInfoCard extends StatelessWidget {
  const ServiceInfoCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
          size: AppConstants.iconM,
        ),
        const SizedBox(height: AppConstants.paddingS),
        Text(label, style: AppTextStyles.labelMuted),
        const SizedBox(height: AppConstants.paddingXS),
        Text(value, style: AppTextStyles.labelBold),
      ],
    );
  }
}
