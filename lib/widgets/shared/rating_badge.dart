import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// -----------------------------------------
// This widget can be reused across screens
// -----------------------------------------

class RatingBadge extends StatelessWidget {
  final String rating;

  const RatingBadge({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 12, color: Color(0xFFF59E0B)),
          const SizedBox(width: 4),
          Text(
            rating,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF92400E),
            ),
          ),
        ],
      ),
    );
  }
}