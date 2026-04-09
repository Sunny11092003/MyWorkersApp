import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home/welcome_header.dart';
import '../widgets/home/search_bar.dart';
import '../widgets/home/offer_card.dart';
import '../widgets/home/categories_section.dart';
import '../widgets/home/service_card.dart';
import '../widgets/home/tracking_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded, color: Colors.black87),
          iconSize: 28,
          onPressed: () {},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Location',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12, 
                color: Colors.grey[600],
                fontWeight: FontWeight.w500
              ),
            ),
            Row(
              children: [
                Text(
                  'Bangalore, India',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 18,
                  color: Color(0xFF4361EE),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFFF3F4F6),
              child: const Icon(Icons.person_outline_rounded, size: 24, color: Colors.black87),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Welcome Text & Search
              const WelcomeHeader(),
              const SizedBox(height: 20),
              const SearchBarWidget(),
              const SizedBox(height: 24),

              // 2. Promotional Offer Card
              const OfferCard(),
              const SizedBox(height: 32),

              // 3. Categories (Circular Professional Design)
              const CategoriesSection(), // Added back as requested
              const SizedBox(height: 32),

              // 4. Recommended Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended Services',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF4361EE),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // 5. Hero Service Cards (The nice UI taking more space)
              const ServiceCard(
                title: 'Professional Deep Home Cleaning',
                rating: '4.9',
                duration: '2-3 Hours',
                price: '45.00',
                imageUrl: 'https://techsquadteam.com/assets/profile/blogimages/9ee372ea2e007c87b293c5e5a9fea6a0.png', 
              ),
              const ServiceCard(
                title: 'Full House Kitchen Plumbing',
                rating: '4.8',
                duration: '1-2 Hours',
                price: '30.00',
                imageUrl: 'https://media.istockphoto.com/id/2205544490/photo/plumber-installing-water-filter-system-under-kitchen-sink.jpg?s=612x612&w=0&k=20&c=Tfo_qXb9Rcc604LBKYdD-nZBGspr7cAE45f4FEHd6Hs=',
              ),
              const ServiceCard(
                title: 'AC Maintenance & Repair',
                rating: '4.7',
                duration: '45 Mins',
                price: '25.00',
                imageUrl: 'https://dioncomfort.com/wp-content/uploads/2024/10/ac-repair.jpg',
              ),

              // 6. Bottom spacing for navigation bar clarity
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}