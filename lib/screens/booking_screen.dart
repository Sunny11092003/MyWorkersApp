import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'add_address_screen.dart';

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
  List<Map> _addresses = [];
  bool _hasCurrentInDB = false;
  String _currentLocation = ""; // passed or fetched
  Map? _selectedAddress;
  final TextEditingController _instructionController = TextEditingController();

  // State Variables
  double _selectedTip = 0.0;

Future<void> _fetchAddresses() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    print("User not logged in");
    return;
  }

  final uid = user.uid;

  // 🔥 GET FULL USER NODE
  final snapshot = await FirebaseDatabase.instance
      .ref("users/$uid")
      .get();

  if (snapshot.exists) {
    final data = Map<String, dynamic>.from(snapshot.value as Map);

    setState(() {
      _addresses = [];

      /// ✅ 1. CURRENT ADDRESS
      if (data["address"] != null && data["address"] != "") {
_addresses.add({
  "type": "current",
  "title": "Current Location",
  "address": data["address"],
  "lat": data["lat"],
  "lng": data["lng"],
});
      }

      /// ✅ 2. SAVED ADDRESSES
      if (data["saved_address"] != null) {
        final saved = Map<String, dynamic>.from(data["saved_address"]);

        saved.forEach((key, value) {
          final addr = Map<String, dynamic>.from(value);

_addresses.add({
  "type": "saved",
  "id": key, // 🔥 IMPORTANT
  "title": addr["label"] ?? "Saved",
  "address": addr["address"] ?? "",
  "lat": addr["latitude"],
  "lng": addr["longitude"],
});
        });
      }

      /// ✅ auto select first
      if (_addresses.isNotEmpty) {
        _selectedAddress = _addresses[0];
      }
    });
  }
}

@override
void initState() {
  super.initState();

   _currentLocation = "";// pass from Home

  _fetchAddresses();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      GestureDetector(
  onTap: () async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddAddressScreen()),
    );

    if (result == true) {
      _fetchAddresses(); // refresh
    }
  },
  child: Text(
    "+ Add New",
    style: TextStyle(
      color: _primaryBlue,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
  ),
),
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
        ],
      ),
      bottomNavigationBar: _buildConfirmButton(),
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
      controller: _instructionController, // ✅ ADD THIS
      maxLines: 2,
      style: const TextStyle(fontSize: 13),
      decoration: InputDecoration(
        hintText: "Add a note for your professional...",
        hintStyle: TextStyle(color: _textSubtle.withOpacity(0.5)),
        filled: true,
        fillColor: _surfaceGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
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
                child: Text(
                  amt == 0 ? "No Tip" : "₹$amt",
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

      /// ✅ CASE 1 & 2 → Saved Addresses
      if (_addresses.isNotEmpty)
        ..._addresses.map((addr) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
child: _addressOption(addr),
          );
        }),


      /// ✅ CASE 3 → No addresses at all
      if (_addresses.isEmpty && !_hasCurrentInDB)
        Column(
          children: [
            GestureDetector(
onTap: () {
  setState(() {
    _selectedAddress = {
      "type": "current",
      "address": _currentLocation,
      "lat": null,
      "lng": null,
    };
  });
},
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: _surfaceGrey,
                  borderRadius: BorderRadius.circular(20),
                ),
child: Row(
  children: [
    Icon(Icons.my_location, color: _textHeading, size: 20),
    const SizedBox(width: 12),
    Text(
      "Use Current Location",
      style: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: _textHeading,
      ),
    ),
  ],
),
              ),
            ),

            GestureDetector(
onTap: () async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const AddAddressScreen()),
  );

  if (result == true) {
    _fetchAddresses(); // 🔥 refresh after adding
  }
},
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _bgWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _primaryBlue),
                ),
             child: Row(
                children: [
                Icon(Icons.add, color: _primaryBlue, size: 20),
                const SizedBox(width: 12),
                Text(
      "Add Address",
      style: GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w700,
        fontSize: 14,
        color: _primaryBlue,
      ),
    ),
  ],
),
              ),
            ),
          ],
        ),
    ],
  );
}

Widget _addressOption(Map addr) {
  bool isSelected = _selectedAddress == addr;

  return GestureDetector(
    onTap: () => setState(() => _selectedAddress = addr),
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? _bgWhite : _surfaceGrey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? _primaryBlue : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
Icon(
  _getAddressIcon(addr),
  color: isSelected ? _primaryBlue : _textSubtle,
  size: 22,
),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(addr["title"],
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w800, fontSize: 14)),
                Text(addr["address"],
                    style: TextStyle(color: _textSubtle, fontSize: 12),
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          if (isSelected)
            Icon(Icons.check_circle_rounded,
                color: _primaryBlue, size: 20),
        ],
      ),
    ),
  );
}

IconData _getAddressIcon(Map addr) {
  if (addr["type"] == "current") {
    return Icons.my_location; // 📍 GPS icon
  }

  String title = (addr["title"] ?? "").toString().toLowerCase();

  if (title.contains("home")) {
    return Icons.home_rounded;
  } else if (title.contains("work") || title.contains("office")) {
    return Icons.work_rounded;
  } else {
    return Icons.location_pin; // default saved
  }
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
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      decoration: BoxDecoration(color: _bgWhite, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, -5))]),
      child: ElevatedButton(
onPressed: () async {

  Map<String, dynamic> bookingData = {
    "status": "confirmed",
    "tip": _selectedTip,
    "instruction": _instructionController.text,
  };

  if (_selectedAddress != null) {
    if (_selectedAddress!["type"] == "saved") {
      bookingData["addressId"] = _selectedAddress!["id"];
    } else {
      bookingData["address"] = _selectedAddress!["address"];
      bookingData["lat"] = _selectedAddress!["lat"];
      bookingData["lng"] = _selectedAddress!["lng"];
    }
  }

  await FirebaseDatabase.instance
      .ref("bookings/${widget.bookingId}")
      .update(bookingData);

  print("BOOKING CONFIRMED");

  // ✅ Show confirmation popup (better UX)
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    insetPadding: const EdgeInsets.symmetric(horizontal: 40),
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. Success Icon with a soft background
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.check_circle_rounded, color: Colors.green, size: 60),
          ),
          const SizedBox(height: 24),
          
          // 2. Title
          const Text(
            "Booking Confirmed",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          
          // 3. Description
          Text(
            "Your booking is confirmed.\nOur partner will arrive at your selected date and time to assist you.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          
          // 4. Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:Color(0xFF4361EE),// Or your primary brand color
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Sweet!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);
},
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryBlue, minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
        child: const Text("Confirm Booking", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
      ),
    );
  }
}