import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_strings.dart';
import 'payment_option_card.dart';
import 'premium_section_header.dart';

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
        PremiumSectionHeader(
          AppStrings.checkoutPaymentMethod,
          icon: Icons.payment,
        ),
        const SizedBox(height: AppConstants.paddingM),
        PaymentOptionCard(
          icon: _PaymentIcon(
            bgColor: AppColors.checkoutAddressIcon,
            icon: Icons.credit_card_rounded,
            iconColor: AppColors.primary,
          ),
          title: AppStrings.checkoutPaymentCard,
          subtitle: AppStrings.checkoutPaymentCardDetail,
          isSelected: selectedIndex == 0,
          isRecommended: true,
          onTap: () => onPaymentSelected(0),
        ),
        const SizedBox(height: AppConstants.paddingS),
        PaymentOptionCard(
          icon: _PaymentIcon(
            bgColor: AppColors.paymentCashBg,
            icon: Icons.payments_rounded,
            iconColor: AppColors.paymentCashIcon,
          ),
          title: AppStrings.checkoutPaymentCash,
          subtitle: '',
          isSelected: selectedIndex == 1,
          onTap: () => onPaymentSelected(1),
        ),
        const SizedBox(height: AppConstants.paddingS),
        PaymentOptionCard(
          icon: _PaymentIcon(
            bgColor: AppColors.paymentWalletBg,
            icon: Icons.account_balance_wallet_rounded,
            iconColor: AppColors.paymentWalletIcon,
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

/// Compact rounded icon container used inside payment option cards.
class _PaymentIcon extends StatelessWidget {
  const _PaymentIcon({
    required this.bgColor,
    required this.icon,
    required this.iconColor,
  });

  final Color bgColor;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingS),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusS),
      ),
      child: Icon(icon, color: iconColor, size: AppConstants.iconM),
    );
  }
}
