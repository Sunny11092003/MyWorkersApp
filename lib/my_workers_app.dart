import 'package:flutter/material.dart';
import 'config/routes/app_routes.dart';
import 'config/routes/route_names.dart';
import 'config/theme/app_theme.dart';

/// Root application widget for MyWorkersApp.
///
/// Configures the global [MaterialApp] with the centralized [AppTheme] from
/// the config layer and delegates route generation to [AppRouter].
class MyWorkersApp extends StatelessWidget {
  const MyWorkersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyWorkersApp',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
