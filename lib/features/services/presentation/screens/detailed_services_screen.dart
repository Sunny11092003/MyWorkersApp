import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/routes/app_routes.dart';

/// Screen that shows the full detail view of a single service.
class DetailedServicesScreen extends StatelessWidget {
  const DetailedServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppStrings.detailedServiceTitle,
          style: TextStyle(color: Colors.black, fontSize: 16),
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
              const _ServiceHeroCard(),
              const SizedBox(height: 24),
              const _ServiceInfoRow(),
              const SizedBox(height: 32),
              const _ServiceExperienceSection(),
              const SizedBox(height: 32),
              const _WhatsIncludedSection(),
              const SizedBox(height: 32),
              const _KineticPromiseSection(),
              const SizedBox(height: 32),
              const _SelectDateButton(),
              const SizedBox(height: 16),
              const _EstimateTotalSection(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Private section widgets
// ---------------------------------------------------------------------------

class _ServiceHeroCard extends StatelessWidget {
  const _ServiceHeroCard();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Stack(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey[300],
            child: Image.asset(
              AppAssets.deepCleaning,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.image, size: 48)),
              ),
            ),
          ),
          Container(
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withValues(alpha: 0.5),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.bookingPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.star, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text(
                    AppStrings.detailedPremiumBadge,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              AppStrings.detailedHeroTitle,
              style: TextStyle(
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
}

class _ServiceInfoRow extends StatelessWidget {
  const _ServiceInfoRow();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _InfoItem(
            label: AppStrings.detailedDurationLabel,
            value: AppStrings.detailedDurationValue,
            icon: Icons.schedule,
          ),
          _InfoItem(
            label: AppStrings.detailedRatingLabel,
            value: AppStrings.detailedRatingValue,
            icon: Icons.star,
          ),
          _InfoItem(
            label: AppStrings.detailedStartsAtLabel,
            value: AppStrings.detailedStartsAtValue,
            icon: Icons.local_offer,
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: AppColors.bookingPrimary, size: 20),
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
}

class _ServiceExperienceSection extends StatelessWidget {
  const _ServiceExperienceSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.detailedSectionExperience,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppStrings.detailedExperienceText,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[700],
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _WhatsIncludedSection extends StatelessWidget {
  const _WhatsIncludedSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.detailedWhatsIncluded,
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
          children: const [
            _IncludedCard(
              title: AppStrings.includedLivingTitle,
              items: ['Upright vacuum', 'Glass polishing', 'Baseboard detail'],
              bgColor: Color(0xFFE3F2FD),
              icon: Icons.living,
            ),
            _IncludedCard(
              title: AppStrings.includedKitchenTitle,
              items: [
                'Appliance exterior',
                'Degreasing',
                'Cabinet sanitation',
              ],
              bgColor: Color(0xFFE0F7F4),
              icon: Icons.kitchen,
            ),
            _IncludedCard(
              title: AppStrings.includedBathroomTitle,
              items: [
                'Complete scrub down',
                'Grout & fixtures',
                'Deep sanitization',
              ],
              bgColor: Color(0xFFFCE4EC),
              icon: Icons.bathroom,
            ),
            _IncludedCard(
              title: AppStrings.includedSanitizationTitle,
              items: [
                'High-touch surfaces',
                'Disinfection throughout',
                'Home',
              ],
              bgColor: Color(0xFFFFF3E0),
              icon: Icons.shield,
            ),
          ],
        ),
      ],
    );
  }
}

class _IncludedCard extends StatelessWidget {
  const _IncludedCard({
    required this.title,
    required this.items,
    required this.bgColor,
    required this.icon,
  });

  final String title;
  final List<String> items;
  final Color bgColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.bookingPrimary, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 12,
                    color: AppColors.bookingPrimary,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[700],
                      ),
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
}

class _KineticPromiseSection extends StatelessWidget {
  const _KineticPromiseSection();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bookingDark,
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
                  AppStrings.detailedPromiseTitle,
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.detailedPromiseText,
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
}

class _SelectDateButton extends StatelessWidget {
  const _SelectDateButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(
          context,
          AppRoutes.booking,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.bookingPrimary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.detailedSelectDate,
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
}

class _EstimateTotalSection extends StatelessWidget {
  const _EstimateTotalSection();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.detailedEstimateLabel,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.detailedEstimateValue,
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
