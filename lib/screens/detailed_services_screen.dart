import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking_screen.dart';

class DetailedServicesScreen extends StatefulWidget {
  final String title;
  final String rating;
  final String duration;
  final String price;
  final String imageAsset;

  const DetailedServicesScreen({
    super.key,
    required this.title,
    required this.rating,
    required this.duration,
    required this.price,
    required this.imageAsset,
  });

  @override
  State<DetailedServicesScreen> createState() => _DetailedServicesScreenState();
}

class _DetailedServicesScreenState extends State<DetailedServicesScreen> {
  // Theme Variables
  final Color _brandBlue = const Color(0xFF4361EE);
  final Color _darkText = const Color(0xFF111827);
  final Color _lightGrey = const Color(0xFFF9FAFB);

  // --- STATE VARIABLES FOR BOOKING ---
  int selectedDateIndex = 0;
  String selectedTime = "10:00 AM";

  final List<String> times = [
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "01:00 PM",
    "02:00 PM",
    "04:00 PM"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: _darkText, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Service Details",
          style: GoogleFonts.plusJakartaSans(
            color: _darkText,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share_outlined, color: _darkText),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _buildHeroSection(),
                const SizedBox(height: 32),
                _buildStatsCard(),
                const SizedBox(height: 32),
                _buildExperienceSection(),

                const SizedBox(height: 32),
                _buildReviewsSection(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomBookingBar(context),
          ),
        ],
      ),
    );
  }

  // --- UI HELPER METHODS ---

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: _darkText,
      ),
    );
  }

  Widget _buildReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle("Customer Reviews"),
            Text(
              "See All",
              style: GoogleFonts.plusJakartaSans(
                color: _brandBlue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildReviewCard(
          "Alex Johnson",
          "4.8",
          "The team was incredibly professional and left my apartment spotless. Highly recommend!",
          "2 days ago",
        ),
        const SizedBox(height: 12),
        _buildReviewCard(
          "Sarah Williams",
          "5.0",
          "Best service I've booked so far. They even got the tough stains out of the kitchen tile.",
          "1 week ago",
        ),
      ],
    );
  }

  Widget _buildReviewCard(String name, String rate, String comment, String date) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _lightGrey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: _darkText,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, size: 14, color: Color(0xFFFFB703)),
                  const SizedBox(width: 4),
                  Text(
                    rate,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: _darkText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
          ),
          const SizedBox(height: 10),
          Text(
            comment,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: NetworkImage(widget.imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _brandBlue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text(
                    "PREMIUM",
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Text(
              "Revitalize Your\nLiving Sanctuary",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _lightGrey,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          _buildInfoPill(Icons.access_time_filled, widget.duration, _brandBlue),
          const SizedBox(width: 8),
          _buildInfoPill(Icons.star_rounded, widget.rating, const Color(0xFFFFB703)),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "₹ ${widget.price}",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: _darkText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoPill(IconData icon, String value, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: iconColor),
          const SizedBox(width: 6),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: _darkText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle("Service Experience"),
        const SizedBox(height: 12),
        Text(
          "Our signature deep cleaning service goes beyond the surface. We target hidden dust and stubborn stains using eco-friendly materials.",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            color: Colors.grey[600],
            height: 1.6,
          ),
        ),
      ],
    );
  }


  // --- CUSTOM BOOKING LOGIC ---

  Widget _buildBottomBookingBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(context).padding.bottom + 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _showBookingSheet(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: _brandBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: const Text("Select Date & Time", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showBookingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true, // Necessary for custom layouts
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text("Select Date", style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold, color: _darkText)),
                  const SizedBox(height: 16),

                  // Horizontal Date Picker
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: List.generate(7, (index) {
                        DateTime date = DateTime.now().add(Duration(days: index));
                        bool isSelected = selectedDateIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setModalState(() => selectedDateIndex = index);
                            setState(() => selectedDateIndex = index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? _brandBlue : _lightGrey,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][date.weekday % 7],
                                  style: TextStyle(color: isSelected ? Colors.white70 : Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : _darkText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  const SizedBox(height: 32),
                  Text(
  "Select Time",
  style: GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: _darkText,
  ),
),
const SizedBox(height: 20), // Increased spacing from title

// Time Slot Grid 
// We use a GridView.builder with shrinkWrap for better alignment than Wrap
GridView.builder(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: times.length,
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,          // Exactly 3 items per row
    mainAxisSpacing: 12,        // Vertical spacing between rows
    crossAxisSpacing: 12,       // Horizontal spacing between items
    childAspectRatio: 2.5,      // Adjusts the height-to-width ratio of the pills
  ),
  itemBuilder: (context, index) {
    String time = times[index];
    bool isSelected = selectedTime == time;
    
    return GestureDetector(
      onTap: () {
        setModalState(() => selectedTime = time);
        setState(() => selectedTime = time);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? _brandBlue.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? _brandBlue : Colors.grey[200]!, 
            width: isSelected ? 2.0 : 1.5,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: _brandBlue.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ] : [],
        ),
        child: Text(
          time,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            color: isSelected ? _brandBlue : _darkText,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  },
),
const SizedBox(height: 32), // Spacing before the confirm button


ElevatedButton(
  onPressed: () {
    // 1. Close the bottom sheet
    Navigator.pop(context); 

    // 2. Navigate and pass ALL required arguments
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EliteCheckoutScreen(  // <--- ADD THIS LINE TO FIX THE ERROR
        ),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: _brandBlue,
    minimumSize: const Size(double.infinity, 56),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  child: const Text(
    "Confirm Booking", 
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            );
          },
        );
      },
    );
  }
}