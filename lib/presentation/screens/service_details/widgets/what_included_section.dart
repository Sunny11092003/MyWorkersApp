import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import 'included_card.dart';

/// Section displaying a 2-column grid of included services.
class WhatIncludedSection extends StatelessWidget {
  const WhatIncludedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.detailedWhatsIncluded,
          style: AppTextStyles.heading4,
        ),
        const SizedBox(height: AppConstants.paddingL),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: AppConstants.paddingM,
          mainAxisSpacing: AppConstants.paddingM,
          children: const [
            IncludedCard(
              title: AppStrings.includedLivingTitle,
              items: ['Upright vacuum', 'Glass polishing', 'Baseboard detail'],
              bgColor: AppColors.cardLivingBg,
              icon: Icons.living,
            ),
            IncludedCard(
              title: AppStrings.includedKitchenTitle,
              items: [
                'Appliance exterior',
                'Degreasing',
                'Cabinet sanitation',
              ],
              bgColor: AppColors.cardKitchenBg,
              icon: Icons.kitchen,
            ),
            IncludedCard(
              title: AppStrings.includedBathroomTitle,
              items: [
                'Complete scrub down',
                'Grout & fixtures',
                'Deep sanitization',
              ],
              bgColor: AppColors.cardBathroomBg,
              icon: Icons.bathroom,
            ),
            IncludedCard(
              title: AppStrings.includedSanitizationTitle,
              items: [
                'High-touch surfaces',
                'Disinfection throughout',
                'Home',
              ],
              bgColor: AppColors.cardSanitizationBg,
              icon: Icons.shield,
            ),
          ],
        ),
      ],
    );
  }
}
