import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailedServicesScreen extends StatelessWidget {
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

  // Home Page Consistent Palette
  final Color _brandBlue = const Color(0xFF4361EE);
  final Color _darkText = const Color(0xFF111827);
  final Color _lightGrey = const Color(0xFFF9FAFB);

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
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 150), // Extra bottom padding for the bar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. HERO IMAGE
                _buildHeroSection(),
                const SizedBox(height: 24),

                // 2. STATS CARD
                _buildStatsCard(),
                const SizedBox(height: 32),

                // 3. DESCRIPTION
                _buildSectionTitle("Service Experience"),
                const SizedBox(height: 12),
                Text(
                  "Our signature deep cleaning service goes beyond the surface. We target hidden dust, stubborn stains, and allergens in every corner of your home using eco-friendly, hospital-grade disinfectants.",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 32),

                // 4. INCLUSIONS (Fixed Layout)
                _buildSectionTitle("What's Included"),
                const SizedBox(height: 16),
                _buildInclusionsGrid(),

                const SizedBox(height: 32),

                // 5. PROMISE BANNER
              ],
            ),
          ),

          // 6. FIXED BOTTOM BAR
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomBookingBar(),
          ),
        ],
      ),
    );
  }

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

  Widget _buildHeroSection() {
    return Container(
      height: 350,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        image: DecorationImage(
          image: NetworkImage(imageAsset),
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
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: _lightGrey),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem("DURATION", duration, Icons.access_time_filled),
          _buildStatItem("RATING", "$rating (1.2k)", Icons.star_rounded),
          _buildStatItem("STARTS AT", "\$$price", null),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData? icon) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            if (icon != null) Icon(icon, size: 16, color: _brandBlue),
            if (icon != null) const SizedBox(width: 4),
            Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: icon == null ? _brandBlue : _darkText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInclusionsGrid() {
    return Column(
      children: [
        Row(
          children: [
            // Flexible is used here instead of Expanded to prevent layout errors
            Flexible(child: _buildInclusionCard("Living Spaces", "Upholstery vacuum • Glass polishing", Icons.weekend, const Color(0xFFF0F3FF))),
            const SizedBox(width: 12),
            Flexible(child: _buildInclusionCard("Kitchen Detail", "Appliance exterior • Degreasing", Icons.soup_kitchen, const Color(0xFFE0F7F6))),
          ],
        ),
        const SizedBox(height: 12),
        _buildInclusionCard(
          "Bathroom Disinfection",
          "Complete scrub down of tiles, grout, fixtures, and deep sanitization of all surfaces.",
          Icons.sanitizer,
          const Color(0xFFF5F3FF),
          isWide: true,
        ),
      ],
    );
  }

  Widget _buildInclusionCard(String title, String subtitle, IconData icon, Color bg, {bool isWide = false}) {
    return Container(
      width: isWide ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 18,
            child: Icon(icon, size: 18, color: _brandBlue),
          ),
          const SizedBox(height: 12),
          Text(title, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.plusJakartaSans(fontSize: 11, color: Colors.grey[700], height: 1.4),
          ),
        ],
      ),
    );
  }


  Widget _buildBottomBookingBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: _brandBlue,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 56),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Select Date & Time", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}