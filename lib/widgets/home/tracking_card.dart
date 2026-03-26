import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackingCard extends StatelessWidget {
  const TrackingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFF86EFAC)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF86EFAC),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.delivery_dining, color: Color(0xFF166534)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Provider is on the way',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF166534),
                      ),
                    ),
                    Text(
                      'ARRIVING IN 12 MINS',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF15803D),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text(
                  'TRACK',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: 0.75,
              backgroundColor: const Color(0xFFBBF7D0),
              color: const Color(0xFF10B981),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Order placed',
                style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600]),
              ),
              Text(
                'Arriving soon',
                style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}