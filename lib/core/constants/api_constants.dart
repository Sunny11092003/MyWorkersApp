/// API endpoint and configuration constants for MyWorkersApp.
///
/// Replace [baseUrl] and paths with real values when connecting to a backend.
class ApiConstants {
  ApiConstants._();

  // ── Base ──────────────────────────────────────────────────────────────────
  static const String baseUrl = 'https://api.myworkersapp.com/v1';

  // ── Timeout ───────────────────────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // ── Endpoints ─────────────────────────────────────────────────────────────
  static const String services = '/services';
  static const String serviceDetail = '/services/{id}';
  static const String categories = '/categories';
  static const String bookings = '/bookings';
  static const String users = '/users';

  // ── Headers ───────────────────────────────────────────────────────────────
  static const String contentTypeJson = 'application/json';
  static const String authorizationHeader = 'Authorization';
  static const String bearerPrefix = 'Bearer ';
}
