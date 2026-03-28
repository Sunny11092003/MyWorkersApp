import 'package:flutter/material.dart';

/// Controller that manages state for [ServiceDetailsScreen].
///
/// Handles date/time picker interaction and loading state.
/// Extends [ChangeNotifier] so widgets can rebuild reactively.
class ServiceDetailsController extends ChangeNotifier {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;

  DateTime? get selectedDate => _selectedDate;
  TimeOfDay? get selectedTime => _selectedTime;
  bool get isLoading => _isLoading;

  /// Returns a formatted summary of the selected date and time, or null if
  /// neither has been chosen yet.
  String? get selectedDateTimeSummary {
    if (_selectedDate == null && _selectedTime == null) return null;
    final d = _selectedDate;
    final t = _selectedTime;
    final datePart = d != null ? '${d.day}/${d.month}/${d.year}' : '';
    final timePart = t != null
        ? '${t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod}:'
            '${t.minute.toString().padLeft(2, '0')} '
            '${t.period == DayPeriod.am ? 'AM' : 'PM'}'
        : '';
    return '$datePart  $timePart'.trim();
  }

  /// Opens the date picker then the time picker and stores the result.
  ///
  /// Calls [onConfirmed] when both selections are made; [onConfirmed] is
  /// responsible for navigating to the booking screen.
  Future<void> selectDateAndTime(
    BuildContext context,
    VoidCallback onConfirmed,
  ) async {
    _setLoading(true);

    final now = DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (date == null) {
      _setLoading(false);
      return;
    }

    if (!context.mounted) {
      _setLoading(false);
      return;
    }

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    _selectedDate = date;
    _selectedTime = time;
    _setLoading(false);

    onConfirmed();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
