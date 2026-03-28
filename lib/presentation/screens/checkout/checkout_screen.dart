import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/common/custom_appbar.dart';
import 'checkout_controller.dart';
import 'widgets/confirm_booking_button.dart';
import 'widgets/payment_method_section.dart';
import 'widgets/price_summary_section.dart';
import 'widgets/schedule_slot_section.dart';
import 'widgets/selected_service_card.dart';
import 'widgets/service_address_section.dart';

/// Full checkout screen where the user reviews their selected service,
/// picks an address, chooses a schedule slot, selects a payment method,
/// reviews pricing, and confirms the booking.
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final CheckoutController _controller;
  int _selectedAddressIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = CheckoutController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    _controller.confirmBooking(() {
      if (!mounted) return;
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.radiusL),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: AppColors.accent,
              size: 72,
            ),
            const SizedBox(height: AppConstants.paddingL),
            Text(
              AppStrings.bookingSuccess,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.paddingS),
            Text(
              AppStrings.bookingSuccessSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppConstants.paddingXXL),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                    ..pop()
                    ..popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.radiusXL),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.paddingL,
                  ),
                ),
                child: Text(
                  AppStrings.bookingGoHome,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(title: AppStrings.checkoutTitle),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingL,
                    vertical: AppConstants.paddingM,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Selected service ──────────────────────────────
                      _SectionHeader(AppStrings.checkoutSelectedService),
                      const SizedBox(height: AppConstants.paddingS),
                      const SelectedServiceCard(),
                      const SizedBox(height: AppConstants.paddingXXL),

                      // ── Service address ───────────────────────────────
                      ServiceAddressSection(
                        selectedIndex: _selectedAddressIndex,
                        onAddressSelected: (index) =>
                            setState(() => _selectedAddressIndex = index),
                      ),
                      const SizedBox(height: AppConstants.paddingXXL),

                      // ── Schedule slot ─────────────────────────────────
                      ScheduleSlotSection(
                        selectedDateIndex: _controller.selectedDateIndex,
                        selectedTimeIndex: _controller.selectedTimeIndex,
                        onDateSelected: _controller.selectDate,
                        onTimeSelected: _controller.selectTime,
                      ),
                      const SizedBox(height: AppConstants.paddingXXL),

                      // ── Payment method ────────────────────────────────
                      PaymentMethodSection(
                        selectedIndex: _controller.selectedPaymentIndex,
                        onPaymentSelected: _controller.selectPayment,
                      ),
                      const SizedBox(height: AppConstants.paddingXXL),

                      // ── Price summary ─────────────────────────────────
                      const PriceSummarySection(),
                      const SizedBox(height: AppConstants.paddingHuge),
                    ],
                  ),
                ),
              ),

              // ── Confirm button ────────────────────────────────────────
              Container(
                padding: const EdgeInsets.fromLTRB(
                  AppConstants.paddingL,
                  AppConstants.paddingM,
                  AppConstants.paddingL,
                  AppConstants.paddingXXL,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: ConfirmBookingButton(
                  onPressed: _handleConfirm,
                  isLoading: _controller.isLoading,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// A lightweight section-label widget used within the checkout body.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: AppTextStyles.checkoutSectionTitle);
  }
}
