import 'package:flutter/material.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';

/// Displays the estimated total price below the booking button.
class EstimateTotalWidget extends StatelessWidget {
  const EstimateTotalWidget({
    super.key,
    this.estimateLabel = AppStrings.detailedEstimateLabel,
    this.estimateValue = AppStrings.detailedEstimateValue,
  });

  final String estimateLabel;
  final String estimateValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(estimateLabel, style: AppTextStyles.labelCaps),
        const SizedBox(height: AppConstants.paddingS),
        Text(estimateValue, style: AppTextStyles.estimateTotal),
      ],
    );
  }
}
