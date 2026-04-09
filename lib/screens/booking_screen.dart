import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingScreen extends StatefulWidget {
  final String serviceTitle;
  final String price;
  final String imageAsset;
  final DateTime scheduledDateTime;

  const BookingScreen({
    super.key,
    required this.serviceTitle,
    required this.price,
    required this.imageAsset,
    required this.scheduledDateTime,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    // Formatting for display
    final String dateStr = "${widget.scheduledDateTime.day}/${widget.scheduledDateTime.month}/${widget.scheduledDateTime.year}";
    final String timeStr = "${widget.scheduledDateTime.hour.toString().padLeft(2, '0')}:${widget.scheduledDateTime.minute.toString().padLeft(2, '0')}";

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Confirm Booking',
          style: GoogleFonts.plusJakartaSans(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SERVICE SUMMARY ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageAsset,
                      width: 70, 
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 70, height: 70, color: Colors.grey[200], child: const Icon(Icons.image),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.serviceTitle, style: GoogleFonts.plusJakartaSans(fontSize: 16, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text('\$${widget.price}', style: GoogleFonts.plusJakartaSans(fontSize: 16, color: const Color(0xFF4361EE), fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            _sectionLabel('Booking Details'),
            const SizedBox(height: 16),
            _infoRow(Icons.calendar_month_rounded, 'Date', dateStr),
            _infoRow(Icons.access_time_filled_rounded, 'Time', timeStr),
            _infoRow(Icons.location_on_rounded, 'Address', 'Bangalore, India'),

            const SizedBox(height: 32),
            _sectionLabel('Payment Summary'),
            const SizedBox(height: 16),
            _priceRow('Service Fee', '\$${widget.price}'),
            _priceRow('Platform Tax', '\$2.00'),
            const Divider(height: 32),
            _priceRow('Total Payable', '\$${(double.tryParse(widget.price) ?? 0.0) + 2.0}', isTotal: true),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF111827),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () => _showSuccessDialog(context),
                child: Text(
                  'Confirm & Pay',
                  style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(text, style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.w800));
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF4361EE)),
          const SizedBox(width: 12),
          Text('$label: ', style: GoogleFonts.plusJakartaSans(color: Colors.grey[600])),
          Text(value, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String val, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.plusJakartaSans(fontSize: isTotal ? 16 : 14, fontWeight: isTotal ? FontWeight.w800 : FontWeight.w500)),
          Text(val, style: GoogleFonts.plusJakartaSans(fontSize: isTotal ? 18 : 14, fontWeight: isTotal ? FontWeight.w800 : FontWeight.w600, color: isTotal ? const Color(0xFF4361EE) : Colors.black)),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 60),
            const SizedBox(height: 16),
            Text('Booking Confirmed!', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 18)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Back to Home'),
            )
          ],
        ),
      ),
    );
  }
}