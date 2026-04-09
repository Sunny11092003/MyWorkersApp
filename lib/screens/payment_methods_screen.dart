import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/payment/credit_card_item.dart';
import '../widgets/payment/digital_wallet_item.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3F51F3)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Payment Methods',
          style: GoogleFonts.poppins(
            color: const Color(0xFF111827),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Color(0xFF3F51F3)),
            onPressed: () {},
          ),
        ],
      ),
      // Floating Action Button matching the bottom right
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF5C6FE8),
        elevation: 8,
        child: const Icon(Icons.credit_card, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'YOUR WALLET',
              style: GoogleFonts.poppins(
                color: const Color(0xFF3F51F3),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Saved Cards',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF1A1F36),
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Container(width: 24, height: 3, decoration: BoxDecoration(color: const Color(0xFF1D7663), borderRadius: BorderRadius.circular(10))),
              ],
            ),
            const SizedBox(height: 24),

            // The Cards
            const CreditCardItem(
              isVisa: true,
              cardHolder: 'ALEX RIVERS',
              expiry: '09/27',
              lastFour: '4285',
            ),
            const CreditCardItem(
              isVisa: false,
              cardHolder: 'ALEX RIVERS',
              expiry: '12/25',
              lastFour: '9901',
            ),

            const SizedBox(height: 16),
            
            // Digital Wallets Header
            Row(
              children: [
                Text(
                  'Digital Wallets',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF1A1F36),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: Container(height: 1, color: const Color(0xFFE0E7FF))),
              ],
            ),
            const SizedBox(height: 24),

            // Apple Pay / UPI
            Row(
              children: [
                DigitalWalletItem(
                  icon: Icons.apple,
                  iconBgColor: Colors.black,
                  iconColor: Colors.white,
                  title: 'Apple Pay',
                  statusText: 'ENABLED',
                  statusColor: const Color(0xFF4FE0B5),
                ),
                DigitalWalletItem(
                  icon: Icons.account_balance_wallet,
                  iconBgColor: const Color(0xFF4A65E8),
                  iconColor: Colors.white,
                  title: 'UPI ID',
                  subtitle: 'rivers.alex@bank',
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Dashed Add Button
            _buildDashedAddButton(),

            const SizedBox(height: 40),

            // Footer Labels
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.lock, size: 12, color: Color(0xFF047857)),
                    const SizedBox(width: 8),
                    Text(
                      'PCI-DSS COMPLIANT SECURE ENCRYPTION',
                      style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.bold, color: const Color(0xFF4B5563)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF38B28B), shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text(
                  'Urban Pulse System Status: Optimal',
                  style: GoogleFonts.poppins(fontSize: 10, color: const Color(0xFF9CA3AF)),
                ),
              ],
            ),
            const SizedBox(height: 80), // Fab spacing
          ],
        ),
      ),
    );
  }

  // Uses a custom painter to draw the perfect dashed pill border without extra packages
  Widget _buildDashedAddButton() {
    return CustomPaint(
      painter: DashedRectPainter(color: const Color(0xFFC7D2FE), strokeWidth: 2, gap: 6),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(color: Color(0xFFE0E7FF), shape: BoxShape.circle),
              child: const Icon(Icons.add, color: Color(0xFF3F51F3)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Payment Method', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: const Color(0xFF111827))),
                  Text('Credit, Debit or Prepaid Card', style: GoogleFonts.poppins(fontSize: 12, color: const Color(0xFF6B7280))),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}

// Painter for the dashed border around the Add Payment button
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  DashedRectPainter({required this.color, required this.strokeWidth, required this.gap});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(35));
    Path path = Path()..addRRect(rrect);

    Path dashPath = Path();
    double distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(pathMetric.extractPath(distance, distance + gap), Offset.zero);
        distance += gap * 2;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}