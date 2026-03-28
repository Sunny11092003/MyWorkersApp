import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      builder: (_) => const _SuccessDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.checkoutScaffoldBg,
      appBar: CustomAppBar(title: AppStrings.checkoutTitle),
      body: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          return Column(
            children: [
              // ── Checkout progress indicator ───────────────────────────
              const _CheckoutProgressBar(),

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingL,
                    vertical: AppConstants.paddingM,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Selected service ──────────────────────────────
                      _SectionHeader(
                        AppStrings.checkoutSelectedService,
                        icon: Icons.cleaning_services,
                      ),
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
                      color: AppColors.primary.withValues(alpha: 0.12),
                      blurRadius: 24,
                      offset: const Offset(0, -6),
                    ),
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ConfirmBookingButton(
                      onPressed: _handleConfirm,
                      isLoading: _controller.isLoading,
                    ),
                    const SizedBox(height: AppConstants.paddingS),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: AppConstants.iconXS,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: AppConstants.paddingXS),
                        Text(
                          AppStrings.checkoutSecurePayment,
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Step progress bar ─────────────────────────────────────────────────────────

/// A 3-step progress indicator displayed at the top of the checkout screen.
///
/// Steps: Details → Booking → Confirm.  The user arriving at this screen has
/// already completed steps 1 and 2, so step 3 (Confirm) is shown as active.
class _CheckoutProgressBar extends StatelessWidget {
  const _CheckoutProgressBar();

  static const List<String> _steps = [
    AppStrings.checkoutStepDetails,
    AppStrings.checkoutStepBooking,
    AppStrings.checkoutStepConfirm,
  ];

  /// Index of the currently active step (0-based).  On this screen we are at
  /// step 2 (the "Confirm" step), with 0 and 1 already completed.
  static const int _activeStep = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingXXL,
        vertical: AppConstants.paddingM,
      ),
      child: Row(
        children: List.generate(_steps.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector line between two steps.
            final stepBefore = i ~/ 2;
            final isComplete = _activeStep > stepBefore;
            return Expanded(
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: isComplete
                      ? const LinearGradient(
                          colors: AppColors.primaryGradientColors,
                        )
                      : null,
                  color: isComplete ? null : AppColors.grey300,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            );
          }

          // Step node.
          final stepIndex = i ~/ 2;
          final isComplete = _activeStep > stepIndex;
          final isActive = _activeStep == stepIndex;

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isActive || isComplete
                      ? const LinearGradient(
                          colors: AppColors.primaryGradientColors,
                        )
                      : null,
                  color:
                      isActive || isComplete ? null : AppColors.grey300,
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: isComplete
                      ? const Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 14,
                        )
                      : Text(
                          '${stepIndex + 1}',
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isActive
                                ? AppColors.white
                                : AppColors.grey600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: AppConstants.paddingXS),
              Text(
                _steps[stepIndex],
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight:
                      isActive ? FontWeight.w600 : FontWeight.normal,
                  color: isActive || isComplete
                      ? AppColors.primary
                      : AppColors.grey600,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

// ── Section header ────────────────────────────────────────────────────────────

/// A premium section header with a gradient left-accent bar and an icon.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title, {this.icon});

  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Gradient accent bar
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.primaryGradientColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: AppConstants.paddingS),
        if (icon != null) ...[
          Icon(icon, size: AppConstants.iconM, color: AppColors.primary),
          const SizedBox(width: AppConstants.paddingXS),
        ],
        Text(title, style: AppTextStyles.checkoutSectionTitle),
      ],
    );
  }
}

// ── Success dialog ────────────────────────────────────────────────────────────

/// An animated booking-confirmation dialog with a bouncing success icon.
class _SuccessDialog extends StatefulWidget {
  const _SuccessDialog();

  @override
  State<_SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<_SuccessDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _scaleAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _scaleAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.elasticOut,
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeIn),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusXXL),
      ),
      contentPadding: const EdgeInsets.all(AppConstants.paddingXXL),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated check icon inside a gradient circle.
          ScaleTransition(
            scale: _scaleAnim,
            child: Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: AppColors.successGradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.check_rounded,
                color: AppColors.white,
                size: 48,
              ),
            ),
          ),
          const SizedBox(height: AppConstants.paddingXXL),
          FadeTransition(
            opacity: _fadeAnim,
            child: Column(
              children: [
                Text(
                  AppStrings.bookingSuccess,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.paddingS),
                Text(
                  AppStrings.bookingSuccessSubtitle,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.checkoutAddressBody,
                ),
                const SizedBox(height: AppConstants.paddingXXL),
                // Gradient go-home button.
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                      ..pop()
                      ..popUntil((route) => route.isFirst);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppColors.primaryGradientColors,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusXL,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.bookingGoHome,
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
