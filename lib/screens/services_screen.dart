import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home/search_bar.dart';
import '../widgets/home/service_card.dart';

class ServicesScreen extends StatefulWidget {
  final String categoryName;
  final String categoryId;

  const ServicesScreen({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Matches Home
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          // Consistent with Home's icon style but using Back
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
          iconSize: 22,
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Location',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
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
                  color: Color(0xFF4361EE), // Matches Home accent color
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
              // 1. Consistent Section Header
              Text(
                widget.categoryName,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Find the best professional services near you',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              
              const SizedBox(height: 24),
              
              // 2. Consistent Search (Matches SearchBarWidget on Home)
              SearchBarWidget(), 
              
              const SizedBox(height: 24),

              // 3. Category Pills (Styled like Home's tags)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ['All', 'Popular', 'Low Price', 'Top Rated'].map((filter) {
                    bool isSelected = selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (val) => setState(() => selectedFilter = filter),
                        labelStyle: GoogleFonts.plusJakartaSans(
                          color: isSelected ? Colors.white : const Color(0xFF6B7280),
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                        selectedColor: const Color(0xFF111827),
                        backgroundColor: const Color(0xFFF3F4F6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        side: BorderSide.none,
                        showCheckmark: false,
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 32),

              // 4. Content Header (Matches 'Recommended' styling from Home)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Services',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111827),
                    ),
                  ),
                  IconButton(
  onPressed: () {
    // This is where you will trigger your filter logic or bottom sheet
    print("Filter clicked"); 
    _showFilterBottomSheet(context); // Optional: call a function to show filters
  },
  constraints: const BoxConstraints(), // Removes default padding to keep it aligned
  padding: EdgeInsets.zero,
  icon: const Icon(
    Icons.tune_rounded, 
    color: Color(0xFF4361EE), 
    size: 20,
  ),
),
                ],
              ),
              
              const SizedBox(height: 16),

              // 5. Using the SAME ServiceCard widget as Home for visual unity
              ServiceCard(
                title: 'Professional Deep Home Cleaning',
                rating: '4.9',
                duration: '2-3 Hours',
                price: '45.00',
                imageUrl: 'https://techsquadteam.com/assets/profile/blogimages/9ee372ea2e007c87b293c5e5a9fea6a0.png', 
              ),
              ServiceCard(
                title: 'Full House Kitchen Plumbing',
                rating: '4.8',
                duration: '1-2 Hours',
                price: '30.00',
                imageUrl: 'https://media.istockphoto.com/id/2205544490/photo/plumber-installing-water-filter-system-under-kitchen-sink.jpg?s=612x612&w=0&k=20&c=Tfo_qXb9Rcc604LBKYdD-nZBGspr7cAE45f4FEHd6Hs=',
              ),
              // 5. Available Services List (Expanded)
              ServiceCard(
                title: 'Professional Deep Home Cleaning',
                rating: '4.9',
                duration: '2-3 Hours',
                price: '45.00',
                imageUrl: 'https://harrisfac.com/nitropack_static/BnpSAdOjVbmFnIsiadoFCJikMYNtOKTH/assets/images/optimized/rev-a8092a7/harrisfac.com/wp-content/uploads/2025/08/What-Are-The-5-Cleaning-Methods-1040x693.jpg', 
              ),
              ServiceCard(
                title: 'AC Deep Coil Cleaning',
                rating: '4.7',
                duration: '45 Mins',
                price: '25.00',
                imageUrl: 'https://dioncomfort.com/wp-content/uploads/2024/10/ac-repair.jpg',
              ),
              ServiceCard(
                title: 'Complete Electrical Wiring Check',
                rating: '4.9',
                duration: '2 Hours',
                price: '50.00',
                imageUrl: 'https://static.wixstatic.com/media/16c2b7_5d6f7e8ef4c34a18b77aae5db6887226~mv2.jpg/v1/fill/w_860,h_459,al_c,q_85,enc_avif,quality_auto/16c2b7_5d6f7e8ef4c34a18b77aae5db6887226~mv2.jpg',
              ),
              ServiceCard(
                title: 'Professional Wall Painting',
                rating: '4.6',
                duration: '1-2 Days',
                price: '199.00',
                imageUrl: 'https://jkmaxxpaints.com/wp-content/uploads/2024/08/Blog-18-How-to-Achieve-Professional-Results-When-Painting-Your-Walls-Image.jpg',
              ),
              ServiceCard(
                title: 'Garden Maintenance & Mowing',
                rating: '4.8',
                duration: '2 Hours',
                price: '35.00',
                imageUrl: 'https://musthavemaintenance.com.au/wp-content/uploads/Lawn-mowing-10.jpg',
              ),
              ServiceCard(
                title: 'Sofa & Upholstery Shampooing',
                rating: '4.7',
                duration: '1.5 Hours',
                price: '40.00',
                imageUrl: 'https://www.carpetbright.uk.com/wp-content/uploads/2023/11/Upholstery-Cleaning-Does-it-Make-a-Bif-Difference_.jpeg',
              ),
              ServiceCard(
                title: 'Smart Home Device Installation',
                rating: '5.0',
                duration: '1 Hour',
                price: '60.00',
                imageUrl: 'https://images.unsplash.com/photo-1558002038-1055907df827?q=80&w=400',
              ),
              ServiceCard(
                title: 'Pest Control (General)',
                rating: '4.5',
                duration: '1 Hour',
                price: '45.00',
                imageUrl: 'https://images.unsplash.com/photo-1600121848594-d8644e57abab?q=80&w=400',
              ),
              ServiceCard(
                title: 'Microwave & Oven Repair',
                rating: '4.7',
                duration: '45 Mins',
                price: '20.00',
                imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?q=80&w=400',
              ),
              ServiceCard(
                title: 'Bathroom Leakage Fix',
                rating: '4.8',
                duration: '1 Hour',
                price: '28.00',
                imageUrl: 'https://images.unsplash.com/photo-1584622781564-1d987f7333c1?q=80&w=400',
              ),
              ServiceCard(
                title: 'Wooden Furniture Polishing',
                rating: '4.6',
                duration: '3 Hours',
                price: '75.00',
                imageUrl: 'https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/sites/2/2023/03/01002311/wood-furniture-polish.jpg',
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

void _showFilterBottomSheet(BuildContext context) {
  // Define your dynamic category and sub-type lists here
  final List<Map<String, dynamic>> filterCategories = [
    {'name': 'Cleaning', 'icon': Icons.cleaning_services_rounded},
    {'name': 'Repair', 'icon': Icons.build_rounded},
    {'name': 'Painting', 'icon': Icons.format_paint_rounded},
    {'name': 'Plumbing', 'icon': Icons.water_drop_rounded},
    {'name': 'Electric', 'icon': Icons.bolt_rounded},
  ];

  final List<String> serviceSubTypes = [
    'Deep Clean', 'Express', 'Move-in', 'Sanitization', 'Eco-Friendly'
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24, right: 24, top: 12, 
                bottom: MediaQuery.of(context).viewInsets.bottom + 24
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40, height: 5,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Filter & Sort', style: GoogleFonts.plusJakartaSans(fontSize: 22, fontWeight: FontWeight.w800)),
                      TextButton(onPressed: () => Navigator.pop(context), child: Text('Reset', style: GoogleFonts.plusJakartaSans(color: Colors.redAccent, fontWeight: FontWeight.w700))),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 1. SELECT CATEGORY (Icon Style)
                  _buildFilterLabel('Select Category'),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filterCategories.length,
                      itemBuilder: (context, index) {
                        final cat = filterCategories[index];
                        bool isSelected = index == 0; 
                        return Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: GestureDetector(
                            onTap: () => setModalState(() {}), // Update state on tap
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF4361EE) : const Color(0xFFF3F4F6),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(cat['icon'] as IconData, color: isSelected ? Colors.white : Colors.black87, size: 24),
                                ),
                                const SizedBox(height: 8),
                                Text(cat['name'], style: GoogleFonts.plusJakartaSans(fontSize: 12, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? const Color(0xFF4361EE) : Colors.black54)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 2. SERVICE TYPE (New - Filter Sub-Categories)
                  _buildFilterLabel('Service Type'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: serviceSubTypes.map((type) {
                      bool isSelected = type == 'Deep Clean';
                      return FilterChip(
                        label: Text(type),
                        selected: isSelected,
                        onSelected: (val) {},
                        selectedColor: const Color(0xFF4361EE).withOpacity(0.1),
                        checkmarkColor: const Color(0xFF4361EE),
                        labelStyle: GoogleFonts.plusJakartaSans(
                          color: isSelected ? const Color(0xFF4361EE) : Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        backgroundColor: const Color(0xFFF3F4F6),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: BorderSide.none),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // 3. SORT BY
                  _buildFilterLabel('Sort By'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    children: ['Most Popular', 'Top Rated', 'Price: Low to High'].map((sort) {
                      bool isSelected = sort == 'Most Popular';
                      return ChoiceChip(
                        label: Text(sort),
                        selected: isSelected,
                        onSelected: (val) {},
                        selectedColor: const Color(0xFF111827),
                        backgroundColor: const Color(0xFFF3F4F6),
                        labelStyle: GoogleFonts.plusJakartaSans(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontSize: 13,
                        ),
                        side: BorderSide.none,
                        showCheckmark: false,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // 4. PRICE RANGE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFilterLabel('Price Range'),
                      Text('\$20 - \$150', style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700, color: const Color(0xFF4361EE))),
                    ],
                  ),
                  RangeSlider(
                    values: const RangeValues(20, 150),
                    min: 0, max: 250,
                    activeColor: const Color(0xFF4361EE),
                    onChanged: (values) {},
                  ),
                  const SizedBox(height: 32),

                  // 5. APPLY BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF111827),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text('Apply Filters', style: GoogleFonts.plusJakartaSans(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      );
    },
  );
}

Widget _buildFilterLabel(String text) {
  return Text(
    text,
    style: GoogleFonts.plusJakartaSans(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF111827),
    ),
  );
}