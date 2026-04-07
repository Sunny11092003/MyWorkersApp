import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatCard extends StatelessWidget {
  final String value;
  final String label;

  const StatCard({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3F51F3).withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF3F51F3),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label.replaceAll(' ', '\n'), // Splits label into two lines
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: const Color(0xFF6B7280),
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}