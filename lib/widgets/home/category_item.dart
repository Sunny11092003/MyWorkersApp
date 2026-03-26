import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, size: 32, color: const Color(0xFF4361EE)),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}