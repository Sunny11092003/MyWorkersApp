import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_workers_app/screens/onboarding_screen.dart';

class MyWorkersApp extends StatelessWidget {
  const MyWorkersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4361EE),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const ProfessionalOnboardingScreen(),
    );
  }
}
