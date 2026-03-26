import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeHeader extends StatelessWidget {
  const WelcomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back, Alex',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'What can we help you with today?',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}