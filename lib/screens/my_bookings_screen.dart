import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking_details_screen.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> with SingleTickerProviderStateMixin {
  List<Map> pending = [];
  List<Map> ongoing = [];
  List<Map> history = [];
  bool isLoading = true;

  // Animation controller for the shimmer effect
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _fetchBookings();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> _fetchBookings() async {
    // ... (Your existing Firebase fetch logic remains exactly the same)
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final uid = user.uid;
    final userSnap = await FirebaseDatabase.instance.ref("users/$uid/bookings").get();

    if (!userSnap.exists) {
      setState(() => isLoading = false);
      return;
    }

    final bookingIds = Map<String, dynamic>.from(userSnap.value as Map);
    List<Map> tempPending = [];
    List<Map> tempOngoing = [];
    List<Map> tempHistory = [];

    for (String id in bookingIds.keys) {
      final snap = await FirebaseDatabase.instance.ref("bookings/$id").get();
      if (!snap.exists) continue;

      final booking = Map<String, dynamic>.from(snap.value as Map);
      booking["id"] = id;

      final serviceSnap = await FirebaseDatabase.instance.ref("services/${booking["serviceId"]}").get();
      if (serviceSnap.exists) {
        final serviceData = Map<String, dynamic>.from(serviceSnap.value as Map);
        booking["serviceName"] = serviceData["title"];
        booking["serviceImage"] = serviceData["image"];
      }

      String status = (booking["status"] ?? "").toString().toLowerCase();

      if (status == "ongoing" || status == "confirmed") {
        tempOngoing.add(booking);
      } else if (status == "initiated") {
        tempPending.add(booking);
      } else if (status == "completed" || status == "cancelled") {
        tempHistory.add(booking);
      }
    }

    setState(() {
      ongoing = tempOngoing;
      pending = tempPending;
      history = tempHistory;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6F8),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "My Bookings",
            style: GoogleFonts.plusJakartaSans(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          bottom: TabBar(
            indicatorColor: const Color(0xFF4361EE),
            indicatorWeight: 3,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey[400],
            labelStyle: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, fontSize: 14),
            tabs: const [
              Tab(text: "Ongoing"),
              Tab(text: "Pending"),
              Tab(text: "History"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildList(ongoing, "No ongoing tasks"),
            _buildList(pending, "No pending requests"),
            _buildList(history, "No past history"),
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<Map> list, String emptyMsg) {
    if (isLoading) {
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Show 5 skeleton cards while loading
        itemBuilder: (context, index) => _buildSkeletonCard(),
      );
    }

    if (list.isEmpty) {
      return Center(
        child: Text(emptyMsg, style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 15)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: list.length,
      itemBuilder: (context, index) => _bookingCard(list[index]),
    );
  }

  // --- SKELETON LOADING WIDGET ---
  Widget _buildSkeletonCard() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Skeleton Image
                  _shimmerBlock(60, 60, borderRadius: 12),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimmerBlock(20, 140), // Skeleton Title
                        const SizedBox(height: 8),
                        _shimmerBlock(15, 100), // Skeleton Date
                        const SizedBox(height: 12),
                        _shimmerBlock(24, 80, borderRadius: 6), // Skeleton Chip
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Divider(height: 1, color: Color(0xFFF3F4F6)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: _shimmerBlock(12, double.infinity), // Skeleton Address
              )
            ],
          ),
        );
      },
    );
  }

  Widget _shimmerBlock(double height, double width, {double borderRadius = 4}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: const [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
          stops: const [0.1, 0.5, 0.9],
          begin: Alignment(-1.0 + _shimmerController.value * 2, -0.3),
          end: Alignment(1.0 + _shimmerController.value * 2, 0.3),
        ),
      ),
    );
  }

  // --- ACTUAL DATA CARD ---
  Widget _bookingCard(Map booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BookingDetailsScreen(bookingId: booking["id"])),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: booking["serviceImage"] != null
                        ? Image.network(booking["serviceImage"], height: 60, width: 60, fit: BoxFit.cover)
                        : Container(
                            height: 60, width: 60, color: Colors.grey[50],
                            child: const Icon(Icons.category_outlined, color: Colors.grey),
                          ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking["serviceName"] ?? "Service",
                          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: -0.4),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${booking["date"]} • ${booking["time"]}",
                          style: GoogleFonts.plusJakartaSans(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 12),
                        _statusChip(booking["status"] ?? "unknown"),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Color(0xFFD1D5DB), size: 24),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Divider(height: 1, color: Color(0xFFF3F4F6)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        booking["address"] ?? "Home",
                        style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    Color color;
    String label = status.toUpperCase();
    switch (status.toLowerCase()) {
      case "confirmed": color = const Color(0xFF10B981); break;
      case "ongoing": color = const Color(0xFFF59E0B); break;
      case "completed": color = const Color(0xFF4361EE); break;
      case "cancelled": color = const Color(0xFFEF4444); break;
      case "initiated": color = Colors.grey[700]!; label = "PENDING"; break;
      default: color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: GoogleFonts.plusJakartaSans(color: color, fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5),
      ),
    );
  }
}