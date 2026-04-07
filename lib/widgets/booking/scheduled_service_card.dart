import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduledServiceCard extends StatelessWidget {
  final String title;
  final String date;
  final String status;
  final String price;

  const ScheduledServiceCard({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final bool isConfirmed = status == 'Confirmed';
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF111827),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isConfirmed ? const Color(0xFFD1FAE5) : const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: GoogleFonts.poppins(
                    color: isConfirmed ? const Color(0xFF059669) : const Color(0xFFD97706),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Color(0xFF6B7280)),
              const SizedBox(width: 6),
              Text(
                date,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF4361EE),
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF4361EE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: const Color(0xFF4361EE).withOpacity(0.3)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  elevation: 0,
                ),
                child: Text(
                  'Reschedule',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}