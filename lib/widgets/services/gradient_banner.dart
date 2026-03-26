import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientBanner extends StatelessWidget {
  final String categoryName;

  const GradientBanner({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4361EE), Color.fromARGB(255, 181, 176, 255)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            categoryName,
            style: GoogleFonts.poppins(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Professional services for every corner.",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}