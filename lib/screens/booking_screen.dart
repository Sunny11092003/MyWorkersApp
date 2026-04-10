import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderSummaryScreen extends StatefulWidget {
  final String serviceTitle;
  final String price;
  final String imageAsset;
  final DateTime scheduledDateTime;

  const OrderSummaryScreen({
    super.key,
    required this.serviceTitle,
    required this.price,
    required this.imageAsset,
    required this.scheduledDateTime,
  });

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  // Brand Colors from your Home Screen
  final Color primaryBlue = const Color(0xFF4361EE);
  final Color textBlack = const Color(0xFF111827);
  final Color textGrey = const Color(0xFF6B7280);
  final Color bgGrey = const Color(0xFFF3F4F6); // Background contrast color
  final Color successGreen = const Color(0xFF10B981);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  _buildServiceCard(),
                  const SizedBox(height: 10),
                  _buildScheduleCard(),
                  const SizedBox(height: 10),
                  _buildAddressCard(),
                  const SizedBox(height: 10),
                  _buildBillDetailCard(),
                  const SizedBox(height: 10),
                  _buildCancellationPolicy(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          _buildZomatoStyleFooter(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: textBlack, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Confirm Order",
        style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w800,
          fontSize: 17,
          color: textBlack,
        ),
      ),
    );
  }

  Widget _buildServiceCard() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(widget.imageAsset, height: 70, width: 70, fit: BoxFit.cover),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.serviceTitle,
                  style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 16, color: textBlack),
                ),
                const SizedBox(height: 4),
                Text(
                  "Professional Service • 1 Unit",
                  style: GoogleFonts.plusJakartaSans(fontSize: 13, color: textGrey),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.verified_user_rounded, color: successGreen, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      "Service Guarantee Included",
                      style: GoogleFonts.plusJakartaSans(fontSize: 11, fontWeight: FontWeight.w700, color: successGreen),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: primaryBlue.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(Icons.timer_outlined, color: primaryBlue, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Scheduled Time", style: GoogleFonts.plusJakartaSans(fontSize: 12, color: textGrey, fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(
                  "${DateFormat('EEE, d MMM').format(widget.scheduledDateTime)} | ${DateFormat('hh:mm a').format(widget.scheduledDateTime)}",
                  style: GoogleFonts.plusJakartaSans(fontSize: 15, fontWeight: FontWeight.w800, color: textBlack),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Change", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: primaryBlue)),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on_rounded, color: primaryBlue, size: 20),
              const SizedBox(width: 8),
              Text("Service Location", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Home • 7th Block, HSR Layout, Bangalore, 560102",
            style: GoogleFonts.plusJakartaSans(fontSize: 14, color: textBlack, fontWeight: FontWeight.w500, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildBillDetailCard() {
    double base = double.tryParse(widget.price.replaceAll(',', '')) ?? 0.0;
    double tax = base * 0.18; // GST 18%
    double platformFee = 2.0;
    double total = base + tax + platformFee;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Bill Details", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 16),
          _billRow("Item total", "\$${base.toStringAsFixed(2)}"),
          _billRow("Taxes and Service Fee", "\$${tax.toStringAsFixed(2)}"),
          _billRow("Platform fee", "\$${platformFee.toStringAsFixed(2)}"),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(thickness: 1, color: Color(0xFFF3F4F6)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Payable", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900, fontSize: 16, color: textBlack)),
              Text("\$${total.toStringAsFixed(2)}", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900, fontSize: 18, color: textBlack)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _billRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.plusJakartaSans(color: textGrey, fontSize: 13, fontWeight: FontWeight.w500)),
          Text(value, style: GoogleFonts.plusJakartaSans(color: textBlack, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildCancellationPolicy() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
        child: Row(
          children: [
            const Icon(Icons.info_outline, size: 16, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "Cancellation policy applies. Review before booking.",
                style: GoogleFonts.plusJakartaSans(fontSize: 11, color: textGrey, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZomatoStyleFooter() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 34),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "\$${widget.price}",
                  style: GoogleFonts.plusJakartaSans(fontSize: 20, fontWeight: FontWeight.w900, color: textBlack),
                ),
                Text(
                  "VIEW DETAILED BILL",
                  style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: primaryBlue, letterSpacing: 0.5),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 52,
            width: 180,
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.heavyImpact();
                // Final API Call here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Place Order", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 16)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}