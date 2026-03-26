import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterChips extends StatelessWidget {
  final String label;

  const FilterChips({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}