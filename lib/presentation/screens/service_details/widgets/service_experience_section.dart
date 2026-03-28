import 'package:flutter/material.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// Section that describes the service experience in detail.
class ServiceExperienceSection extends StatelessWidget {
  const ServiceExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.detailedSectionExperience,
          style: AppTextStyles.heading4,
        ),
        const SizedBox(height: AppConstants.paddingM),
        Text(
          AppStrings.detailedExperienceText,
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }
}
