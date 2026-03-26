import 'package:flutter/material.dart';
import '../widgets/services/gradient_banner.dart';
import '../widgets/services/filter_chip.dart';
import '../widgets/services/featured_card.dart';
import '../widgets/services/service_card_vertical.dart';
import '../widgets/services/active_booking_card.dart';

class ServicesScreen extends StatelessWidget {
  final String categoryName;
  final String categoryId;

  const ServicesScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(Icons.arrow_back, color: Colors.black87),
          ),
          iconSize: 28,
          onPressed: () => Navigator.pop(context),
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            GradientBanner(categoryName: categoryName),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const FilterChips(label: 'Price'),
                  const SizedBox(width: 10),
                  const FilterChips(label: 'Rating'),
                  const SizedBox(width: 10),
                  const FilterChips(label: 'Popular'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const FeaturedCard(),
            const SizedBox(height: 24),
            ServiceCardVertical(
              title: 'Quick Refresh Clean',
              rating: '4.7',
              duration: '1 HR',
              price: '45',
              imageAsset: 'assets/images/quick_clean.webp',
            ),
            const SizedBox(height: 20),
            ServiceCardVertical(
              title: 'Move-in / Move-out',
              rating: '5.0',
              duration: '4-6 HRS',
              price: '150',
              imageAsset: 'assets/images/move_clean.png',
            ),
            const SizedBox(height: 24),
            const ActiveBookingCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}