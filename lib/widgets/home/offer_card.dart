import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4361EE), Color(0xFF6C63FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NEW USER SPECIAL',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '50% Off First Visit',
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Transform your space with our premium services.',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF4361EE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  elevation: 0,
                ),
                child: Text(
                  'Claim Now',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -20,
          right: -30,
          child: Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFBBDEFB).withValues(alpha: 0.2), // softer
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFBBDEFB).withValues(alpha: 0.15),
                  blurRadius: 25,
                  spreadRadius: 3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}