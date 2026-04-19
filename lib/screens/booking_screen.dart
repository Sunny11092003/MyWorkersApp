import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';

class EliteCheckoutScreen extends StatefulWidget {
  final Map service;
  final String selectedDate;
  final String selectedTime;
  final String bookingId;

  const EliteCheckoutScreen({
    super.key,
    required this.service,
    required this.selectedDate,
    required this.selectedTime,
    required this.bookingId,
  });
  
  @override
  State<EliteCheckoutScreen> createState() => _EliteCheckoutScreenState();
}

class _EliteCheckoutScreenState extends State<EliteCheckoutScreen> {
  // Theme Palette
  final Color _primaryBlue = const Color(0xFF4361EE);
  final Color _bgWhite = Colors.white;
  final Color _surfaceGrey = const Color(0xFFF8FAFC);
  final Color _textHeading = const Color(0xFF0F172A);
  final Color _textSubtle = const Color(0xFF64748B);

  // State Variables
  String _selectedAddress = "Home";
  double _selectedTip = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgWhite,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _buildSectionLabel("SELECTED SERVICE"),
                  _buildServiceCard(),

                  const SizedBox(height: 16),

Container(
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: _surfaceGrey,
    borderRadius: BorderRadius.circular(16),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text(
        "Scheduled",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(
        "${widget.selectedDate} • ${widget.selectedTime}",
        style: TextStyle(color: _textSubtle),
      ),
    ],
  ),
),

                  const SizedBox(height: 32),
                  _buildSectionLabel("OFFERS & BENEFITS"),
                  _buildCouponSection(),

                  const SizedBox(height: 32),
                  _buildSectionLabel("SERVICE INSTRUCTIONS"),
                  _buildInstructionField(),

                  const SizedBox(height: 32),
                  _buildSectionLabel("APPRECIATE YOUR PRO"),
                  _buildTipSection(),

                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSectionLabel("SERVICE ADDRESS"),
                      Text("+ Add New", style: TextStyle(color: _primaryBlue, fontWeight: FontWeight.bold, fontSize: 12)),
                    ],
                  ),
                  _buildAddressSelection(),

                  const SizedBox(height: 32),
                  _buildSectionLabel("PAYMENT METHOD"),
                  _buildPaymentMethods(),

                  const SizedBox(height: 32),
                  _buildPriceSummary(),

                  const SizedBox(height: 24),
                  _buildSecurityNote(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          _buildConfirmButton(),
        ],
      ),
    );
  }

  // --- UI SECTIONS ---

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _bgWhite,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: _textHeading, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text("Checkout", 
        style: GoogleFonts.plusJakartaSans(color: _textHeading, fontWeight: FontWeight.w800, fontSize: 16)),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 11, fontWeight: FontWeight.w900, color: _textSubtle.withOpacity(0.6), letterSpacing: 1.1));
  }

Widget _buildServiceCard() {
  return Container(
    margin: const EdgeInsets.only(top: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _bgWhite,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: _textSubtle.withOpacity(0.1)),
    ),
    child: Row(
      children: [
        Container(
          height: 64,
          width: 64,
          decoration: BoxDecoration(
            color: _surfaceGrey,
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(widget.service["image"] ?? ""),
              fit: BoxFit.cover, // ✅ IMPORTANT (prevents weird stretch)
            ),
          ),
        ),
        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.service["title"] ?? "",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: _textHeading,
                ),
              ),

              Text(
                widget.service["subtitle"] ?? "",
                style: TextStyle(
                  color: _textSubtle,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  Icon(Icons.star_rounded,
                      color: Colors.amber[600], size: 14),
                  const SizedBox(width: 4),

                  // ✅ Make rating dynamic
                  Text(
                    "${widget.service["rating"] ?? "0"}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Text(
          "₹${widget.service["price"] ?? 0}",
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w900,
            fontSize: 18,
            color: _primaryBlue,
          ),
        ),
      ],
    ),
  );
}

  Widget _buildCouponSection() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: _bgWhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withOpacity(0.5), width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.local_offer_rounded, color: Colors.green[600], size: 20),
          const SizedBox(width: 12),
          Text("PRO50", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.green[700])),
          const SizedBox(width: 8),
          Text("applied", style: TextStyle(color: Colors.green[600], fontSize: 13)),
          const Spacer(),
          Text("Remove", style: TextStyle(color: Colors.red[400], fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildInstructionField() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: TextField(
        maxLines: 2,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: "Add a note for your professional...",
          hintStyle: TextStyle(color: _textSubtle.withOpacity(0.5)),
          filled: true,
          fillColor: _surfaceGrey,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  Widget _buildTipSection() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [10.0, 20.0, 50.0, 0.0].map((amt) {
          bool isSelected = _selectedTip == amt;
          return GestureDetector(
            onTap: () => setState(() => _selectedTip = amt),
            child: Container(
              width: 75,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? _primaryBlue : _bgWhite,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isSelected ? _primaryBlue : _textSubtle.withOpacity(0.1)),
              ),
              child: Center(
                child: Text(amt == 0 ? "Other" : "₹$amt",
                  style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 13, color: isSelected ? Colors.white : _textHeading)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAddressSelection() {
    return Column(
      children: [
        const SizedBox(height: 12),
        _addressOption("Home", "1248 Oakwood Ave, Sunset District", Icons.home_filled),
        const SizedBox(height: 12),
        _addressOption("Work", "Salesforce Tower, 415 Mission St", Icons.work_rounded),
      ],
    );
  }

  Widget _addressOption(String title, String desc, IconData icon) {
    bool isSelected = _selectedAddress == title;
    return GestureDetector(
      onTap: () => setState(() => _selectedAddress = title),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? _bgWhite : _surfaceGrey,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? _primaryBlue : Colors.transparent, width: 2),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? _primaryBlue : _textSubtle, size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
                Text(desc, style: TextStyle(color: _textSubtle, fontSize: 12), overflow: TextOverflow.ellipsis),
              ]),
            ),
            if (isSelected) Icon(Icons.check_circle_rounded, color: _primaryBlue, size: 20),
          ],
        ),
      ),
    );
  }

Widget _buildPaymentMethods() {
  return Container(
    margin: const EdgeInsets.only(top: 12),
    decoration: BoxDecoration(
      color: _bgWhite,
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: _textSubtle.withOpacity(0.1)),
    ),
    child: Column(
      children: [
        _paymentTile("UPI (GPay / PhonePe)", Icons.bolt_rounded, isSelected: true),
        Divider(height: 1, color: _textSubtle.withOpacity(0.05)),

        _paymentTile("Credit / Debit Card", Icons.credit_card),
        Divider(height: 1, color: _textSubtle.withOpacity(0.05)),

        // ✅ Added Cash option
        _paymentTile("Cash on Delivery", Icons.payments_rounded),
      ],
    ),
  );
}

  Widget _paymentTile(String title, IconData icon, {bool isSelected = false}) {
    return ListTile(
      leading: Icon(icon, color: _textHeading, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
      trailing: Icon(isSelected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded, 
                     color: isSelected ? _primaryBlue : _textSubtle.withOpacity(0.3)),
    );
  }

Widget _buildPriceSummary() {
  double price = (widget.service["price"] ?? 0).toDouble();
  double gst = price * 0.18;
  double platformFee = 25;
  double total = price + gst + platformFee + _selectedTip;

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _surfaceGrey,
      borderRadius: BorderRadius.circular(24),
    ),
    child: Column(
      children: [
        _priceRow("Subtotal", "₹${price.toStringAsFixed(0)}"),
        _priceRow("Platform Fee", "₹${platformFee.toStringAsFixed(0)}"),
        _priceRow("GST (18%)", "₹${gst.toStringAsFixed(0)}"),

        if (_selectedTip > 0)
          _priceRow("Tip", "₹$_selectedTip"),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(height: 1),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total Amount",
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),

            Text(
              "₹${total.toStringAsFixed(0)}",
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: _textHeading,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

  Widget _priceRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: TextStyle(color: _textSubtle, fontWeight: FontWeight.w600, fontSize: 13)),
        Text(val, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
      ]),
    );
  }

  Widget _buildSecurityNote() {
    return Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.lock_rounded, size: 12, color: _textSubtle),
      const SizedBox(width: 8),
      Text("SECURE ENCRYPTED CHECKOUT", 
        style: GoogleFonts.plusJakartaSans(fontSize: 10, fontWeight: FontWeight.w800, color: _textSubtle, letterSpacing: 0.5)),
    ]));
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      decoration: BoxDecoration(color: _bgWhite, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, -5))]),
      child: ElevatedButton(
        onPressed: () async {
  await FirebaseDatabase.instance
      .ref("bookings/${widget.bookingId}/status")
      .set("confirmed");

  print("BOOKING CONFIRMED");

  Navigator.pop(context);
},
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryBlue, minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
        child: const Text("Confirm Booking", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
      ),
    );
  }
}