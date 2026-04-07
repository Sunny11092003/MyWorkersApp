import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../shared/ticket_separator.dart';

class InteractiveAddressCard extends StatelessWidget {
  final String label;
  final String distance;
  final String address;
  final String contactName;
  final String phoneNumber;
  final bool isDefault;
  final bool isSelected;
  final VoidCallback onTap;

  const InteractiveAddressCard({
    super.key,
    required this.label,
    required this.distance,
    required this.address,
    required this.contactName,
    required this.phoneNumber,
    this.isDefault = false,
    required this.isSelected,
    required this.onTap,
  });

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
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
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
                // Status Chip (Default Address)
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEE2E2), // Reddish pastel
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, size: 14, color: Color(0xFF059669)), // Green icon example
                        const SizedBox(width: 6),
                        Text(
                          'DEFAULT ADDRESS',
                          style: GoogleFonts.poppins(color: const Color(0xFF059669), fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                const Spacer(),
                // Action Icons (Delete, Edit)
                _buildActionIcon(Icons.delete_outline, const Color(0xFFFCA5A5), const Color(0xFFDC2626)),
                const SizedBox(width: 12),
                _buildActionIcon(Icons.edit_outlined, const Color(0xFFF3F4F6), textLight),
              ],
            ),
          ),
          
          const TicketSeparator(punchedRadius: 16),

          // Body
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1 (Icon & Address Type)
                Row(
                  children: [
                    // Home Icon Placeholder
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(color: bgPastelBlue, borderRadius: BorderRadius.circular(16)),
                      child: Icon(label.contains('Home') ? Icons.home : Icons.work, color: primaryBlue, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700, color: textDark),
                          ),
                          Row(
                            children: [
                              Icon(Icons.near_me, size: 12, color: textLight),
                              const SizedBox(width: 4),
                              Text(
                                distance,
                                style: GoogleFonts.poppins(fontSize: 12, color: textLight),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Row 2 (Address Details)
                Text('Address Details', style: GoogleFonts.poppins(fontSize: 11, color: textLight, fontWeight: FontWeight.w600)),
                Text(address, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: textDark)),
                const SizedBox(height: 16),
                // Row 3 (Contact Details)
                Row(
                  children: [
                    Expanded(child: Text('Contact Person', style: GoogleFonts.poppins(fontSize: 11, color: textLight, fontWeight: FontWeight.w600))),
                    const SizedBox(width: 16),
                    Expanded(child: Text('Phone Number', style: GoogleFonts.poppins(fontSize: 11, color: textLight, fontWeight: FontWeight.w600))),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text(contactName, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: textDark))),
                    const SizedBox(width: 16),
                    Expanded(child: Text(phoneNumber, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: textDark))),
                  ],
                ),
              ],
            ),
          ),

          const TicketSeparator(punchedRadius: 16),

          // Footer (Selection Status)
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select this address',
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: textDark),
                    ),
                    // Custom Radio Button UI
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF10B981) : Colors.transparent, // Green fill example
                        shape: BoxShape.circle,
                        border: isSelected ? null : Border.all(color: Colors.grey.shade300, width: 2),
                      ),
                      child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 16) : null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
      child: Icon(icon, size: 20, color: iconColor),
    );
  }
}