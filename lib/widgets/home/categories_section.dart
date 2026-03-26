import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_workers_app/screens/services_screen.dart';
import 'category_item.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Top Categories',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
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
                'See All',
                style: GoogleFonts.poppins(
                  color: const Color(0xFF4361EE),
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
                title: 'Plumbing',
                icon: Icons.water_damage,
                backgroundColor: Colors.blue[100]!,
                onTap: () {},
              ),
              CategoryItem(
                title: 'Cleaning',
                icon: Icons.cleaning_services,
                backgroundColor: Colors.green[100]!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServicesScreen(
                        categoryName: 'Home Cleaning',
                        categoryId: 'cleaning',
                      ),
                    ),
                  );
                },
              ),
              CategoryItem(
                title: 'Electrical',
                icon: Icons.electrical_services,
                backgroundColor: Colors.orange[100]!,
                onTap: () {},
              ),
              CategoryItem(
                title: 'Salon',
                icon: Icons.content_cut,
                backgroundColor: Colors.pink[100]!,
                onTap: () {},
              ),
              CategoryItem(
                title: 'Painting',
                icon: Icons.palette,
                backgroundColor: Colors.purple[100]!,
                onTap: () {},
              ),
              CategoryItem(
                title: 'Appliances',
                icon: Icons.kitchen,
                backgroundColor: Colors.amber[100]!,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
