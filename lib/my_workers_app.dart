import 'package:flutter/material.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'features/booking/presentation/screens/booking_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/services/presentation/screens/detailed_services_screen.dart';
import 'features/services/presentation/screens/services_screen.dart';

/// Root application widget for MyWorkersApp.
///
/// Configures the global [MaterialApp] with the centralized [AppTheme],
/// named route table ([AppRoutes]), and the initial home screen.
class MyWorkersApp extends StatelessWidget {
  const MyWorkersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyWorkersApp',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      onGenerateRoute: _generateRoute,
    );
  }

  static Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case AppRoutes.services:
        final rawArgs = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => ServicesScreen(
            categoryId: rawArgs['categoryId'] as String? ?? '',
            categoryName: rawArgs['categoryName'] as String? ?? '',
          ),
        );

      case AppRoutes.serviceDetail:
        return MaterialPageRoute(
          builder: (_) => const DetailedServicesScreen(),
        );

      case AppRoutes.booking:
        return MaterialPageRoute(
          builder: (_) => const BookingScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
