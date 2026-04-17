import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_workers_app/screens/detailed_services_screen.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String rating;
  final String duration;
  final String price;
  final String? imageAssetPath;
  final String? imageUrl;
  final String id;

  static const Color _brandColor = Color(0xFF4361EE);
  static const Color _textMain = Color(0xFF111827); // Darker for high contrast
  static const Color _textMuted = Color(0xFF6B7280);

const ServiceCard({
  super.key,
  required this.id, // ✅ ADD
  required this.title,
  required this.rating,
  required this.duration,
  required this.price,
  this.imageAssetPath,
  this.imageUrl,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Takes full horizontal space
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Large Hero Image Section
          _buildHeroImage(),

          // 2. Info Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderRow(),
                const SizedBox(height: 12),
                _buildDetailsRow(),
                const SizedBox(height: 20),
                const Divider(color: Color(0xFFF3F4F6), height: 1),
                const SizedBox(height: 20),
                _buildBottomActionRow(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: SizedBox(
            height: 220, // Taller image for more impact
            width: double.infinity,
            child: _getImageWidget(),
          ),
        ),
        // Floating Rating Badge on top of Image
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Color(0xFFFFB800), size: 18),
                const SizedBox(width: 4),
                Text(
                  rating,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                    color: _textMain,
                  ),
                ),
              ],
            ),
          ),
        ),
        // "Verified" or Category Tag
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _brandColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'BEST SELLER',
              style: GoogleFonts.plusJakartaSans(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderRow() {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: _textMain,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildDetailsRow() {
    return Row(
      children: [
        _buildIconInfo(Icons.schedule_rounded, duration),
        const SizedBox(width: 16),
        _buildIconInfo(Icons.verified_user_outlined, 'Insured'),
        const SizedBox(width: 16),
        _buildIconInfo(Icons.local_offer_outlined, 'Fixed Price'),
      ],
    );
  }

  Widget _buildIconInfo(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: _textMuted),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Starting from',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _textMuted,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '\$$price',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: _textMain,
                  ),
                ),
                Text(
                  '/hr',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
        _buildBookButton(context),
      ],
    );
  }

  Widget _buildBookButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onBookPressed(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: _brandColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 0,
      ),
      child: Text(
        'Book Now',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

void _onBookPressed(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => DetailedServicesScreen(
      serviceId: id,
      ),
    ),
  );
}

Widget _getImageWidget() {
    // Priority 1: Check if URL exists
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!, 
        fit: BoxFit.cover,
        // Optional: Adds a loading spinner while the image downloads
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: const Color(0xFFF9FAFB),
            child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          );
        },
      );
    } 
    // Priority 2: Fallback to Asset
    else if (imageAssetPath != null && imageAssetPath!.isNotEmpty) {
      return Image.asset(imageAssetPath!, fit: BoxFit.cover);
    }
    // Priority 3: Placeholder icon if both are missing
    return Container(
      color: const Color(0xFFF9FAFB),
      child: const Icon(Icons.broken_image_outlined, color: Color(0xFF6B7280), size: 40),
    );
  }
}