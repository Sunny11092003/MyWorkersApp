import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'track_booking.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String bookingId;

  const BookingDetailsScreen({super.key, required this.bookingId});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> with SingleTickerProviderStateMixin {
  Map? booking;
  bool isLoading = true;
  late AnimationController _shimmerController;

  Future<void> _cancelBooking(String? reason) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;
    final bookingId = widget.bookingId;

    /// ✅ 1. Update booking status
    await FirebaseDatabase.instance
        .ref("bookings/$bookingId")
        .update({
      "status": "cancelled",
      "cancelReason": reason ?? "No reason provided",
      "cancelledAt": DateTime.now().millisecondsSinceEpoch,
    });

    /// ✅ 2. Remove from user bookings
    await FirebaseDatabase.instance
        .ref("users/$uid/bookings/$bookingId")
        .remove();

    /// ✅ 3. Update UI
    setState(() {
      booking!["status"] = "cancelled";
    });

    /// ✅ 4. Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Booking cancelled successfully")),
    );

    Navigator.pop(context);

  } catch (e) {
    print("Cancel Error: $e");
  }
}
  
Future<void> _showCancelSheet() async {
  String? selectedReason;
  final TextEditingController customReasonController = TextEditingController();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder( // To update selection state inside the sheet
        builder: (context, setModalState) {
          return Container(
            padding: EdgeInsets.only(
              left: 24, right: 24, top: 12, 
              bottom: MediaQuery.of(context).viewInsets.bottom + 40,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Handle Bar (Swiggy Style)
                Center(
                  child: Container(
                    width: 40, height: 4,
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
                  ),
                ),

                // 2. Title Section
                Text("Cancel Booking", 
                  style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900, fontSize: 22, letterSpacing: -0.5)),
                const SizedBox(height: 8),
                Text("Please let us know why you are cancelling. This helps us improve our service.", 
                  style: GoogleFonts.plusJakartaSans(color: Colors.grey[500], fontSize: 13, height: 1.5)),
                const SizedBox(height: 24),

                // 3. Quick Options Wrap
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _reasonChip("Changed my mind", selectedReason, (val) => setModalState(() => selectedReason = val)),
                    _reasonChip("Booked by mistake", selectedReason, (val) => setModalState(() => selectedReason = val)),
                    _reasonChip("Wrong address", selectedReason, (val) => setModalState(() => selectedReason = val)),
                    _reasonChip("Expert delayed", selectedReason, (val) => setModalState(() => selectedReason = val)),
                  ],
                ),
                const SizedBox(height: 20),

                // 4. Custom Reason Input
                TextField(
                  controller: customReasonController,
                  style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: "Other reason (optional)",
                    hintStyle: GoogleFonts.plusJakartaSans(color: Colors.grey[400]),
                    filled: true,
                    fillColor: const Color(0xFFF8F9FA),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                    contentPadding: const EdgeInsets.all(18),
                  ),
                ),
                const SizedBox(height: 32),

                // 5. Action Buttons (Dual Column)
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                        child: Text("GO BACK", style: GoogleFonts.plusJakartaSans(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 14)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          String finalReason = customReasonController.text.isNotEmpty 
                              ? customReasonController.text 
                              : (selectedReason ?? "No reason provided");
                          await _cancelBooking(finalReason);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A1A1A), // Uber-style Black
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text("CONFIRM", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _reasonChip(String text, String? selected, Function(String) onSelect) {
  bool isSelected = text == selected;
  return InkWell(
    onTap: () => onSelect(text),
    borderRadius: BorderRadius.circular(12),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF4361EE).withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? const Color(0xFF4361EE) : const Color(0xFFE5E7EB),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.plusJakartaSans(
          color: isSelected ? const Color(0xFF4361EE) : Colors.black87,
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
        ),
      ),
    ),
  );
}

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _fetchBooking();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> _fetchBooking() async {
    final snap = await FirebaseDatabase.instance.ref("bookings/${widget.bookingId}").get();

    if (snap.exists) {
      final data = Map<String, dynamic>.from(snap.value as Map);
      
      final serviceSnap = await FirebaseDatabase.instance.ref("services/${data["serviceId"]}").get();
      if (serviceSnap.exists) {
        data.addAll(Map<String, dynamic>.from(serviceSnap.value as Map));
      }

      setState(() {
        booking = data;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Booking Summary",
          style: GoogleFonts.plusJakartaSans(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 17),
        ),
      ),
      body: isLoading ? _buildSkeleton() : _buildContent(),
      bottomNavigationBar: _buildBottomAction(),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Status Banner (Urban Company Style)
          _buildStatusBanner(),
          const SizedBox(height: 20),

          // 2. Service & Professional Info
          _buildSectionLabel("Service Details"),
          _buildInfoCard(
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        booking!["image"] ?? "https://via.placeholder.com/150",
                        height: 60, width: 60, fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(booking!["title"] ?? "Home Cleaning",
                              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 16)),
                          const SizedBox(height: 4),
                          Text("${booking!["date"]} at ${booking!["time"]}",
                              style: GoogleFonts.plusJakartaSans(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 32),
                _buildDetailRow(Icons.location_on, "Service Address", booking!["address"] ?? "Home Address"),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 3. Payment Details (Zomato/Swiggy Style)
          _buildSectionLabel("Payment Summary"),
          _buildInfoCard(
            child: Column(
              children: [
                _buildPriceRow("Item Total", "₹${booking!["price"] ?? "0"}"),
                _buildPriceRow("Service Fee", "₹49"),
                _buildPriceRow("Taxes & Charges", "₹22"),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(thickness: 1, color: Color(0xFFF1F1F1)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Paid", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 16)),
                    Text("₹${(int.tryParse(booking!["price"].toString()) ?? 0) + 71}",
                        style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 16, color: const Color(0xFF4361EE))),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.green.withOpacity(0.05), borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_user_outlined, size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Text("Payment via ${booking!["paymentMethod"] ?? "Online Payment"}",
                          style: GoogleFonts.plusJakartaSans(color: Colors.green, fontSize: 12, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildStatusBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [const Color(0xFF4361EE), const Color(0xFF4361EE).withOpacity(0.8)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                booking!["status"].toString().toUpperCase(),
                style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "We are ensuring a top-quality service for you.",
            style: GoogleFonts.plusJakartaSans(color: Colors.white.withOpacity(0.9), fontSize: 12),
          ),
          // Inside the Column of _buildStatusBanner
const SizedBox(height: 16),
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TrackBookingScreen(bookingId: widget.bookingId))),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white, // White button on Blue background
      foregroundColor: const Color(0xFF4361EE),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    child: Text("Track Live Status", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800)),
  ),
), 
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.plusJakartaSans(color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w500)),
          Text(value, style: GoogleFonts.plusJakartaSans(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.grey[400]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: GoogleFonts.plusJakartaSans(color: Colors.grey[500], fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(value, style: GoogleFonts.plusJakartaSans(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(text, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.black)),
    );
  }

  Widget _buildInfoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF1F1F1)),
      ),
      child: child,
    );
  }

  Widget _buildBottomAction() {
    if (isLoading || booking!["status"] == "cancelled") return const SizedBox();
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {}, // For Help Support
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text("NEED HELP?", style: GoogleFonts.plusJakartaSans(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: _showCancelSheet,// Usually for Re-book or Rate
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text("CANCEL BOOKING", style: GoogleFonts.plusJakartaSans(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _shimmerBlock(100, double.infinity, borderRadius: 20),
          const SizedBox(height: 20),
          _shimmerBlock(150, double.infinity, borderRadius: 20),
          const SizedBox(height: 20),
          _shimmerBlock(200, double.infinity, borderRadius: 20),
        ],
      ),
    );
  }

  Widget _shimmerBlock(double height, double width, {double borderRadius = 4}) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) => Container(
        height: height, width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            colors: const [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
            stops: const [0.1, 0.5, 0.9],
            begin: Alignment(-1.0 + _shimmerController.value * 2, -0.3),
            end: Alignment(1.0 + _shimmerController.value * 2, 0.3),
          ),
        ),
      ),
    );
  }
}