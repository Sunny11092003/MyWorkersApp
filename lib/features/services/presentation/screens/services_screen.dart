import 'package:flutter/material.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../widgets/active_booking_card.dart';
import '../widgets/featured_card.dart';
import '../widgets/filter_chip_widget.dart';
import '../widgets/gradient_banner.dart';
import '../widgets/service_card_vertical.dart';

/// Screen displaying a list of services for a given category.
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  final String categoryName;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
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
              AppStrings.yourLocation,
              style: TextStyle(fontSize: 12, color: Colors.grey[800]),
            ),
            const Row(
              children: [
                Text(
                  AppStrings.locationName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Icon(
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
                  FilterChipWidget(label: AppStrings.filterPrice),
                  const SizedBox(width: 10),
                  FilterChipWidget(label: AppStrings.filterRating),
                  const SizedBox(width: 10),
                  FilterChipWidget(label: AppStrings.filterPopular),
                ],
              ),
            ),
            const SizedBox(height: 24),
            FeaturedCard(
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.serviceDetail,
                arguments: {'serviceId': 'eco'},
              ),
            ),
            const SizedBox(height: 24),
            ServiceCardVertical(
              title: AppStrings.serviceQuickRefresh,
              rating: '4.7',
              duration: '1 HR',
              price: '45',
              imageAsset: AppAssets.quickClean,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.serviceDetail,
                arguments: {'serviceId': 'quick'},
              ),
            ),
            const SizedBox(height: 20),
            ServiceCardVertical(
              title: AppStrings.serviceMoveInOut,
              rating: '5.0',
              duration: '4-6 HRS',
              price: '150',
              imageAsset: AppAssets.moveCleaning,
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.serviceDetail,
                arguments: {'serviceId': 'move'},
              ),
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
