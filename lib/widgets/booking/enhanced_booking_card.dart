import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/ticket_separator.dart';

class EnhancedBookingCard extends StatelessWidget {
  const EnhancedBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF3F51F3);
    final Color textDark = const Color(0xFF111827);
    final Color textLight = const Color(0xFF6B7280);
    final Color bgPastelBlue = const Color(0xFFEEF2FF);

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Service Icon Placeholder
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(color: bgPastelBlue, borderRadius: BorderRadius.circular(16)),
                  child: Icon(Icons.cleaning_services, color: primaryBlue, size: 24), // Example icon
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mar 12',
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700, color: textDark),
                      ),
                      Text(
                        'Monday • 02:00 PM',
                        style: GoogleFonts.poppins(fontSize: 12, color: textLight),
                      ),
                    ],
                  ),
                ),
                // Status Chip (Pill shape)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: bgPastelBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check, size: 14, color: primaryBlue),
                      const SizedBox(width: 6),
                      Text(
                        'Completed',
                        style: GoogleFonts.poppins(color: primaryBlue, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const TicketSeparator(punchedRadius: 16),

          // Body
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Service Details Row
                _buildInfoRow(
                  title: 'Full Home Deep Cleaning',
                  subtitle: '1 Day Service • 3 Workers',
                  icon: Icons.cleaning_services_outlined,
                  textDark: textDark,
                  textLight: textLight,
                ),
                const SizedBox(height: 16),
                // Payment Details Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Total Payment', style: GoogleFonts.poppins(fontSize: 12, color: textLight)),
                          Text('\$89.50', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: primaryBlue)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle), child: Icon(Icons.payment, size: 20, color: textLight)),
                  ],
                ),
              ],
            ),
          ),

          const TicketSeparator(punchedRadius: 16),

          // Footer (Button and Subtext)
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: const Color(0xFFE0E7FF), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(padding: const EdgeInsets.all(10), decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle), child: Icon(Icons.cleaning_services_outlined, size: 20, color: primaryBlue)),
                      const SizedBox(width: 16),
                      Text(
                        'House Maid Service',
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: textDark),
                      ),
                      const Spacer(),
                      Icon(Icons.chevron_right, color: Colors.grey.shade400),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Maid service to clean house',
                  style: GoogleFonts.poppins(fontSize: 12, color: textLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String title, required String subtitle, required IconData icon, required Color textDark, required Color textLight}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: textDark, height: 1.3)),
              Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: textLight)),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle), child: Icon(icon, size: 20, color: textLight)),
      ],
    );
  }
}