import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home/search_bar.dart';
import '../widgets/home/service_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shimmer/shimmer.dart';

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
  List services = [];
  bool loading = true;
  String selectedFilter = 'All';

  @override
void initState() {
  super.initState();
  fetchServices(); // ✅ THIS WAS MISSING
}

  Future<void> fetchServices() async {
  try {
    final snapshot = await FirebaseDatabase.instance.ref("services").get();

    if (snapshot.exists) {
      final data = snapshot.value as Map;

      List temp = [];

      data.forEach((key, value) {
        temp.add({
          "id": key,
          ...value
        });
      });

      setState(() {
        services = temp;
        loading = false;
      });
    }
  } catch (e) {
    print("ERROR: $e");
  }
}

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
loading
  ? Column(
      children: const [
        ServiceCardSkeleton(),
        ServiceCardSkeleton(),
        ServiceCardSkeleton(),
      ],
    )
  : Column(
      children: services.map((service) {
        return ServiceCard(
          id: service["id"],
          title: service["title"] ?? "",
          rating: service["rating"]?.toString() ?? "0",
          duration: service["duration"] ?? "",
          price: service["price"]?.toString() ?? "0",
          imageUrl: service["image"] ?? "",
        );
      }).toList(),
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

class ServiceCardSkeleton extends StatelessWidget {
  const ServiceCardSkeleton({super.key});

  Widget _box({double height = 20, double width = double.infinity}) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 IMAGE
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _box(height: 18, width: 200), // title
                  _box(height: 14, width: 120), // subtitle

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(child: _box(height: 30)),
                      const SizedBox(width: 8),
                      Expanded(child: _box(height: 30)),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _box(height: 20, width: 80), // price
                      _box(height: 40, width: 100), // button
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}