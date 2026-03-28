import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import 'address_item.dart';

/// Section that shows saved service addresses and an add-new option.
///
/// Receives the currently selected address index and an [onAddressSelected]
/// callback so the parent can manage state.
class ServiceAddressSection extends StatelessWidget {
  const ServiceAddressSection({
    super.key,
    required this.selectedIndex,
    required this.onAddressSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onAddressSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.checkoutServiceAddress,
          style: AppTextStyles.checkoutSectionTitle,
        ),
        const SizedBox(height: AppConstants.paddingM),
        AddressItem(
          icon: Icons.home_outlined,
          title: AppStrings.checkoutAddressHome,
          subtitle: AppStrings.checkoutAddressHomeSubtitle,
          isSelected: selectedIndex == 0,
          onTap: () => onAddressSelected(0),
        ),
        const SizedBox(height: AppConstants.paddingS),
        AddressItem(
          icon: Icons.business_outlined,
          title: AppStrings.checkoutAddressWork,
          subtitle: AppStrings.checkoutAddressWorkSubtitle,
          isSelected: selectedIndex == 1,
          onTap: () => onAddressSelected(1),
        ),
        const SizedBox(height: AppConstants.paddingM),
        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              const Icon(
                Icons.add_circle_outline,
                color: AppColors.primary,
                size: AppConstants.iconM,
              ),
              const SizedBox(width: AppConstants.paddingS),
              Text(
                AppStrings.checkoutAddNewAddress,
                style: AppTextStyles.checkoutAddressTitle.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
