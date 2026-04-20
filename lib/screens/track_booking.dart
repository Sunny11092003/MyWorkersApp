import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrackBookingScreen extends StatelessWidget {
  final String bookingId;
  const TrackBookingScreen({super.key, required this.bookingId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Track Service",
          style: GoogleFonts.plusJakartaSans(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // 1. Top Status Card
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer_outlined, color: Color(0xFF4361EE)),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Arriving in 15 mins", 
                      style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 16)),
                    Text("Professional is on the way", 
                      style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 12)),
                  ],
                )
              ],
            ),
          ),

          // 2. Main Tracking Timeline
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(32),
              children: [
                _buildTrackStep(
                  title: "Booking Confirmed",
                  subtitle: "We have assigned a professional for your task.",
                  time: "10:30 AM",
                  isCompleted: true,
                  isLast: false,
                ),
                _buildTrackStep(
                  title: "Professional Assigned",
                  subtitle: "John Doe (Verified Master Plumber) is coming.",
                  time: "10:45 AM",
                  isCompleted: true,
                  isLast: false,
                ),
                _buildTrackStep(
                  title: "On the way",
                  subtitle: "Our expert has left for your location.",
                  time: "11:05 AM",
                  isCompleted: true,
                  isCurrent: true,
                  isLast: false,
                ),
                _buildTrackStep(
                  title: "Service in Progress",
                  subtitle: "Estimated time: 45 mins",
                  time: "--:--",
                  isCompleted: false,
                  isLast: false,
                ),
                _buildTrackStep(
                  title: "Completion",
                  subtitle: "Confirm completion via OTP",
                  time: "--:--",
                  isCompleted: false,
                  isLast: true,
                ),
              ],
            ),
          ),

          // 3. Bottom Professional Profile (Floating style)
          _buildProfessionalCard(),
        ],
      ),
    );
  }

  Widget _buildTrackStep({
    required String title,
    required String subtitle,
    required String time,
    required bool isCompleted,
    bool isCurrent = false,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? const Color(0xFF4361EE) : Colors.white,
                  border: Border.all(
                    color: isCompleted ? const Color(0xFF4361EE) : Colors.grey[300]!,
                    width: 2,
                  ),
                ),
                child: isCompleted 
                  ? const Icon(Icons.check, size: 14, color: Colors.white) 
                  : isCurrent ? Container(margin: const EdgeInsets.all(4), decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF4361EE))) : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? const Color(0xFF4361EE) : Colors.grey[200],
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, 
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w800, 
                          fontSize: 15,
                          color: isCompleted || isCurrent ? Colors.black : Colors.grey[400],
                        )),
                      Text(time, 
                        style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, 
                    style: GoogleFonts.plusJakartaSans(
                      color: isCompleted || isCurrent ? Colors.grey[600] : Colors.grey[300], 
                      fontSize: 13,
                      height: 1.4,
                    )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfessionalCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage("https://randomuser.me/api/portraits/men/32.jpg"),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("John Doe", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 17)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 14),
                    const SizedBox(width: 4),
                    Text("4.9 (120 reviews)", style: GoogleFonts.plusJakartaSans(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          // Call Button
          Container(
            decoration: const BoxDecoration(color: Color(0xFF4361EE), shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.phone, color: Colors.white, size: 20),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}