import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import 'payment_option_card.dart';

/// Section listing available payment methods for the checkout.
///
/// The caller manages [selectedIndex] and provides [onPaymentSelected].
class PaymentMethodSection extends StatelessWidget {
  const PaymentMethodSection({
    super.key,
    required this.selectedIndex,
    required this.onPaymentSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onPaymentSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.checkoutPaymentMethod,
          style: AppTextStyles.checkoutSectionTitle,
        ),
        const SizedBox(height: AppConstants.paddingM),
        PaymentOptionCard(
          icon: Container(
            padding: const EdgeInsets.all(AppConstants.paddingS),
            decoration: BoxDecoration(
              color: AppColors.checkoutAddressIcon,
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
            ),
            child: const Icon(
              Icons.credit_card,
              color: AppColors.primary,
              size: AppConstants.iconM,
            ),
          ),
          title: AppStrings.checkoutPaymentCard,
          subtitle: AppStrings.checkoutPaymentCardDetail,
          isSelected: selectedIndex == 0,
          onTap: () => onPaymentSelected(0),
        ),
        const SizedBox(height: AppConstants.paddingS),
        PaymentOptionCard(
          icon: Container(
            padding: const EdgeInsets.all(AppConstants.paddingS),
            decoration: BoxDecoration(
              color: AppColors.paymentCashBg,
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: AppColors.paymentCashIcon,
              size: AppConstants.iconM,
            ),
          ),
          title: AppStrings.checkoutPaymentCash,
          subtitle: '',
          isSelected: selectedIndex == 1,
          onTap: () => onPaymentSelected(1),
        ),
        const SizedBox(height: AppConstants.paddingS),
        PaymentOptionCard(
          icon: Container(
            padding: const EdgeInsets.all(AppConstants.paddingS),
            decoration: BoxDecoration(
              color: AppColors.paymentWalletBg,
              borderRadius: BorderRadius.circular(AppConstants.radiusS),
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.paymentWalletIcon,
              size: AppConstants.iconM,
            ),
          ),
          title: AppStrings.checkoutPaymentWallet,
          subtitle: AppStrings.checkoutPaymentWalletBalance,
          isSelected: selectedIndex == 2,
          onTap: () => onPaymentSelected(2),
        ),
      ],
    );
  }
}
