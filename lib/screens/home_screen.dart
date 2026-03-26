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
        leading: IconButton(
          icon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: const Icon(Icons.menu, color: Colors.black87),
          ),
          iconSize: 28,
          onPressed: () {},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Location',
              style: TextStyle(fontSize: 12, color: Colors.grey[800]),
            ),
            Row(
              children: [
                const Text(
                  'New York, NY',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: Colors.black87,
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black87,
              size: 28,
            ),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[200],
              child: const Icon(Icons.person, size: 24, color: Colors.black87),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeHeader(),
              const SizedBox(height: 20),
              const SearchBarWidget(),
              const SizedBox(height: 24),
              const OfferCard(),
              const SizedBox(height: 24),
              const CategoriesSection(),
              const SizedBox(height: 24),
              Text(
                'Most Popular Services',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              ServiceCard(
                title: 'Full Home Deep Cleaning',
                rating: '4.8',
                duration: '3-5 Hours',
                price: '89',
                imageAssetPath: 'assets/images/deep_cleaning.jpg',
              ),
              const SizedBox(height: 16),
              ServiceCard(
                title: 'AC Servicing & Repair',
                rating: '4.9',
                duration: '1-2 Hours',
                price: '45',
                imageAssetPath: 'assets/images/ac_repair.jpg',
              ),
              const SizedBox(height: 24),
              const TrackingCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}