import 'package:flutter/material.dart';

/// Controller that manages state for [CheckoutScreen].
///
/// Tracks the selected date slot index, time slot index, and payment method.
/// Extends [ChangeNotifier] so widgets can rebuild reactively.
class CheckoutController extends ChangeNotifier {
  int _selectedDateIndex = 0;
  int _selectedTimeIndex = 0;
  int _selectedPaymentIndex = 0;
  bool _isLoading = false;

  int get selectedDateIndex => _selectedDateIndex;
  int get selectedTimeIndex => _selectedTimeIndex;
  int get selectedPaymentIndex => _selectedPaymentIndex;
  bool get isLoading => _isLoading;

  void selectDate(int index) {
    if (_selectedDateIndex == index) return;
    _selectedDateIndex = index;
    notifyListeners();
  }

  void selectTime(int index) {
    if (_selectedTimeIndex == index) return;
    _selectedTimeIndex = index;
    notifyListeners();
  }

  void selectPayment(int index) {
    if (_selectedPaymentIndex == index) return;
    _selectedPaymentIndex = index;
    notifyListeners();
  }

  /// Simulates booking confirmation with a brief loading delay.
  Future<void> confirmBooking(VoidCallback onSuccess) async {
    _isLoading = true;
    notifyListeners();

    await Future<void>.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();

    onSuccess();
  }
}
