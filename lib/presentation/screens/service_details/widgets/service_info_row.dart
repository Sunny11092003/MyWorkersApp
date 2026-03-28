import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import 'service_info_card.dart';

/// Row of three info items: duration, rating and price.
class ServiceInfoRow extends StatelessWidget {
  const ServiceInfoRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingL),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(AppConstants.radiusL),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          ServiceInfoCard(
            label: AppStrings.detailedDurationLabel,
            value: AppStrings.detailedDurationValue,
            icon: Icons.schedule,
          ),
          ServiceInfoCard(
            label: AppStrings.detailedRatingLabel,
            value: AppStrings.detailedRatingValue,
            icon: Icons.star,
          ),
          ServiceInfoCard(
            label: AppStrings.detailedStartsAtLabel,
            value: AppStrings.detailedStartsAtValue,
            icon: Icons.local_offer,
          ),
        ],
      ),
    );
  }
}
