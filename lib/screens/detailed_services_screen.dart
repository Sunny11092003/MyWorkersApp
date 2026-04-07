import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Full Home Deep Cleaning',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Card with Image
              _buildServiceCard(),
              const SizedBox(height: 24),
              
              // Duration, Rating, Price Row
              _buildServiceInfo(),
              const SizedBox(height: 32),
              
              // Service Experience Section
              _buildServiceExperience(),
              const SizedBox(height: 32),
              
              // What's Included Section
              _buildWhatsIncluded(),
              const SizedBox(height: 32),
              
              // Kinetic Promise Section
              _buildKineticPromise(),
              const SizedBox(height: 32),
              
              // Select Date & Time Button
              _buildSelectDateButton(),
              const SizedBox(height: 16),
              
              // Estimate Total
              _buildEstimateTotal(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Stack(
        children: [
          // Image placeholder
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey[300],
            child: Image.network(
              'https://via.placeholder.com/400x300?text=Living+Room',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Center(
                    child: Text('Image Placeholder'),
                  ),
                );
              },
            ),
          ),
          // Gradient Overlay
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                ],
              ),
            ),
          ),
          // Premium Badge
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF5B5FFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star, color: Colors.white, size: 14),
                  const SizedBox(width: 4),
                  Text(
                    'PREMIUM',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Title Overlay
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              'Revitalize Your\nLiving Sanctuary',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem('DURATION', '4-6 hrs', Icons.schedule),
          _buildInfoItem('RATING', '4.9 (1.2k)', Icons.star),
          _buildInfoItem('STARTS AT', '\$149', Icons.local_offer),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF5B5FFF), size: 20),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Service Experience',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Our signature deep cleaning service goes beyond the surface. We target hidden dust, stubborn stains, and allergens in every corner of your home using eco-friendly, hospital-grade disinfectants. Designed for those who demand a medical-grade level of hygiene and a hotel-fresh feel.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[700],
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildWhatsIncluded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What\'s Included',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            _buildIncludedCard(
              'Living Spaces',
              ['Upright vacuum', 'Glass polishing', 'Baseboard detail'],
              const Color(0xFFE3F2FD),
              Icons.living,
            ),
            _buildIncludedCard(
              'Kitchen Detail',
              ['Appliance exterior', 'Degreasing', 'Cabinet sanitation'],
              const Color(0xFFE0F7F4),
              Icons.kitchen,
            ),
            _buildIncludedCard(
              'Bathroom Disinfection',
              ['Complete scrub down', 'Grout & fixtures', 'Deep sanitization'],
              const Color(0xFFFCE4EC),
              Icons.bathroom,
            ),
            _buildIncludedCard(
              'Full Sanitization',
              ['High-touch surfaces', 'Disinfection throughout', 'Home'],
              const Color(0xFFFFF3E0),
              Icons.shield,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIncludedCard(String title, List<String> items, Color bgColor, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF5B5FFF), size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: [
                const Icon(Icons.check_circle, size: 12, color: Color(0xFF5B5FFF)),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    item,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildKineticPromise() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1e3f),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.shield, color: Colors.white, size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'The Kinetic Promise',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Every professional is background-checked and vetted. 100% satisfaction or we clean it again for free.',
                  style: GoogleFonts.poppins(
                    color: Colors.grey[300],
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectDateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF5B5FFF),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Date & Time',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildEstimateTotal() {
    return Column(
      children: [
        Text(
          'ESTIMATE TOTAL',
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '\$149.00',
          style: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}