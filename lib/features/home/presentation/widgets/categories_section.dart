import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

/// Individual category icon+label tile used inside [CategoriesSection].
class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, size: 32, color: AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal scrollable list of service categories.
class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key, this.onCategoryTap});

  /// Optional callback invoked when a category is tapped.
  /// Receives the category id and name.
  final void Function(String categoryId, String categoryName)? onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.topCategories,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                AppStrings.seeAll,
                style: GoogleFonts.poppins(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              CategoryItem(
                title: AppStrings.categoryPlumbing,
                icon: Icons.water_damage,
                backgroundColor: AppColors.categoryBlue,
                onTap: () => onCategoryTap?.call('plumbing', AppStrings.categoryPlumbing),
              ),
              CategoryItem(
                title: AppStrings.categoryCleaning,
                icon: Icons.cleaning_services,
                backgroundColor: AppColors.categoryGreen,
                onTap: () => onCategoryTap?.call(
                  AppStrings.categoryIdCleaning,
                  AppStrings.categoryHomeCleaning,
                ),
              ),
              CategoryItem(
                title: AppStrings.categoryElectrical,
                icon: Icons.electrical_services,
                backgroundColor: AppColors.categoryOrange,
                onTap: () => onCategoryTap?.call('electrical', AppStrings.categoryElectrical),
              ),
              CategoryItem(
                title: AppStrings.categorySalon,
                icon: Icons.content_cut,
                backgroundColor: AppColors.categoryPink,
                onTap: () => onCategoryTap?.call('salon', AppStrings.categorySalon),
              ),
              CategoryItem(
                title: AppStrings.categoryPainting,
                icon: Icons.palette,
                backgroundColor: AppColors.categoryPurple,
                onTap: () => onCategoryTap?.call('painting', AppStrings.categoryPainting),
              ),
              CategoryItem(
                title: AppStrings.categoryAppliances,
                icon: Icons.kitchen,
                backgroundColor: AppColors.categoryAmber,
                onTap: () => onCategoryTap?.call('appliances', AppStrings.categoryAppliances),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
