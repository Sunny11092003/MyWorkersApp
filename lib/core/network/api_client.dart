import 'dart:async';

/// Mocked API client for MyWorkersApp.
///
/// This class simulates HTTP requests to a backend service.
/// Replace the mock implementations with real HTTP calls (e.g. using `http`
/// or `dio`) when the backend is ready.
class ApiClient {
  ApiClient._();

  static final ApiClient instance = ApiClient._();

  static const String _baseUrl = 'https://api.myworkersapp.com/v1';

  String get baseUrl => _baseUrl;

  /// Simulates a GET request to [endpoint].
  /// Returns a [Map<String, dynamic>] payload after a short mock delay.
  Future<Map<String, dynamic>> get(String endpoint) async {
    await _simulateNetworkDelay();
    return _mockResponse(endpoint);
  }

  /// Simulates a POST request to [endpoint] with [body].
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    await _simulateNetworkDelay();
    return {'success': true, 'data': body};
  }

  Future<void> _simulateNetworkDelay() async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  Map<String, dynamic> _mockResponse(String endpoint) {
    if (endpoint.contains('services')) {
      return {
        'success': true,
        'data': [
          {
            'id': '1',
            'title': 'Full Home Deep Cleaning',
            'rating': '4.8',
            'duration': '3-5 Hours',
            'price': '89',
            'imageAsset': 'assets/images/deep_cleaning.jpg',
          },
          {
            'id': '2',
            'title': 'AC Servicing & Repair',
            'rating': '4.9',
            'duration': '1-2 Hours',
            'price': '45',
            'imageAsset': 'assets/images/ac_repair.jpg',
          },
        ],
      };
    }
    if (endpoint.contains('categories')) {
      return {
        'success': true,
        'data': [
          {'id': 'plumbing', 'name': 'Plumbing'},
          {'id': 'cleaning', 'name': 'Cleaning'},
          {'id': 'electrical', 'name': 'Electrical'},
          {'id': 'salon', 'name': 'Salon'},
          {'id': 'painting', 'name': 'Painting'},
          {'id': 'appliances', 'name': 'Appliances'},
        ],
      };
    }
    return {'success': true, 'data': {}};
  }
}
