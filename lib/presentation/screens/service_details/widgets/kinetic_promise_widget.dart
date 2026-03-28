import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// Displays the "Kinetic Promise" guarantee widget.
class KineticPromiseWidget extends StatelessWidget {
  const KineticPromiseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingXL),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(AppConstants.radiusXL),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.shield,
            color: AppColors.white,
            size: AppConstants.iconXL,
          ),
          const SizedBox(width: AppConstants.paddingL),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.detailedPromiseTitle,
                  style: AppTextStyles.promiseTitle,
                ),
                const SizedBox(height: AppConstants.paddingS),
                Text(
                  AppStrings.detailedPromiseText,
                  style: AppTextStyles.promiseBody,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
