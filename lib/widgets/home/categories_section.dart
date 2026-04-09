import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_workers_app/screens/services_screen.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Header ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore Departments',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              ),
              // Hint for user to swipe
              Icon(Icons.swipe_left_rounded, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // --- HORIZONTAL CAROUSEL ---
        // This fixed height prevents vertical space bloat
        SizedBox(
          height: 160, 
          child: PageView(
            controller: PageController(viewportFraction: 0.92), // Shows a peek of the next card
            padEnds: false,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildDepartmentCard(
                context,
                title: 'Home Cleaning',
                description: 'Deep Cleaning & Sanitization',
                priceTag: 'Starting at \$19',
                imageUrl: 'https://cdn.prod.website-files.com/640051ce8a159067e1042e74/65d5b19950d874f282b5c35f_woman-with-gloves-cleaning-floor_23-2148520978.jpg',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ServicesScreen(
                        categoryName: 'Home Cleaning',
                        categoryId: 'cleaning',
                      ),
                    ),
                  );
                },
              ),
              _buildDepartmentCard(
                context,
                title: 'Plumbing & Repairs',
                description: 'Fix Leaks & Installations',
                priceTag: 'Emergency Service',
                imageUrl: 'https://assets-news.housing.com/news/wp-content/uploads/2023/03/24135122/Plumbing-services-Know-types-and-how-to-choose-01.png',
                onTap: () {},
              ),
              _buildDepartmentCard(
                context,
                title: 'Electrical Solutions',
                description: 'Wiring & Appliance Repair',
                priceTag: 'Certified Pros',
                imageUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e?q=80&w=800',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDepartmentCard(
    BuildContext context, {
    required String title,
    required String description,
    required String priceTag,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 12), // Gap between cards
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.black.withOpacity(0.85),
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4361EE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          priceTag,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Text(
                          description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 15,
                  bottom: 15,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}