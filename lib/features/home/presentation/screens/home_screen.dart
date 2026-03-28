import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';
import '../../presentation/widgets/categories_section.dart';
import '../../presentation/widgets/offer_card.dart';
import '../../presentation/widgets/search_bar_widget.dart';
import '../../presentation/widgets/service_card.dart';
import '../../presentation/widgets/tracking_card.dart';
import '../../presentation/widgets/welcome_header.dart';

/// Main home screen of MyWorkersApp.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            child: Icon(Icons.menu, color: Colors.black87),
          ),
          iconSize: 28,
          onPressed: () {},
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
              child: const Icon(
                Icons.person,
                size: 24,
                color: Colors.black87,
              ),
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
              CategoriesSection(
                onCategoryTap: (categoryId, categoryName) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.services,
                    arguments: {
                      'categoryId': categoryId,
                      'categoryName': categoryName,
                    },
                  );
                },
              ),
              const SizedBox(height: 24),
              Text(
                AppStrings.mostPopularServices,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              ServiceCard(
                title: AppStrings.serviceDeepCleaning,
                rating: '4.8',
                duration: '3-5 Hours',
                price: '89',
                imageAssetPath: AppAssets.deepCleaning,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.serviceDetail,
                  arguments: {'serviceId': '1'},
                ),
              ),
              const SizedBox(height: 16),
              ServiceCard(
                title: AppStrings.serviceAcRepair,
                rating: '4.9',
                duration: '1-2 Hours',
                price: '45',
                imageAssetPath: AppAssets.acRepair,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.serviceDetail,
                  arguments: {'serviceId': '2'},
                ),
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
