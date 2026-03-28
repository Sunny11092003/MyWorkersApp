/// Formatting helpers for dates, currencies and other data types.
class Formatters {
  Formatters._();

  // ── Currency ─────────────────────────────────────────────────────────────

  /// Formats [amount] as a USD currency string (e.g. 149.0 → '\$149.00').
  static String currency(double amount) => '\$${amount.toStringAsFixed(2)}';

  /// Formats an integer price value (e.g. 89 → '\$89.00').
  static String intCurrency(int amount) => currency(amount.toDouble());

  // ── Date / Time ──────────────────────────────────────────────────────────

  /// Formats a [DateTime] as 'MMM d, yyyy' (e.g. 'Jan 1, 2025').
  static String date(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }

  /// Formats a [DateTime] as 'h:mm AM/PM' (e.g. '2:30 PM').
  static String time(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  /// Formats a [DateTime] as 'MMM d, yyyy  h:mm AM/PM'.
  static String dateTime(DateTime dt) => '${date(dt)}  ${time(dt)}';

  // ── Rating ───────────────────────────────────────────────────────────────

  /// Formats a rating double to one decimal place (e.g. 4.9).
  static String rating(double value) => value.toStringAsFixed(1);

  // ── Duration ─────────────────────────────────────────────────────────────

  /// Formats minutes into a human-readable string (e.g. 90 → '1h 30m').
  static String durationFromMinutes(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h == 0) return '${m}m';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }
}
