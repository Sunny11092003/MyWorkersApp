import 'package:flutter/material.dart';
import 'route_names.dart';
import '../../features/booking/presentation/screens/booking_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/services/presentation/screens/services_screen.dart';
import '../../presentation/screens/service_details/service_details_screen.dart';

/// Generates named routes for the application.
///
/// Register [onGenerateRoute] with [MaterialApp.onGenerateRoute].
class AppRouter {
  AppRouter._();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RouteNames.services:
        final args =
            settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => ServicesScreen(
            categoryId: args['categoryId'] as String? ?? '',
            categoryName: args['categoryName'] as String? ?? '',
          ),
        );

      case RouteNames.serviceDetail:
        return MaterialPageRoute(
          builder: (_) => const ServiceDetailsScreen(),
        );

      case RouteNames.booking:
        return MaterialPageRoute(builder: (_) => const BookingScreen());

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
