import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/home/search_bar.dart';
import '../widgets/home/offer_card.dart';
import '../widgets/home/categories_section.dart';
import 'Account.dart';
import '../widgets/home/service_card.dart';
import '../screens/services_screen.dart';
import 'package:flutter/services.dart'; // adjust path if needed
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart' as loc;
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = "Enable Location";
  bool showLocationButton = true;
  List services = [];
  bool loadingServices = true;

@override
void initState() {
  super.initState();
  fetchServices();
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

      temp.shuffle(); // 🔥 RANDOMIZE

      setState(() {
        services = temp.take(3).toList(); // ✅ ONLY 3
        loadingServices = false;
      });
    }
  } catch (e) {
    print("ERROR: $e");
  }
}

Future<void> getLocation() async {
  print("🚀 LOCATION STARTED");

loc.Location location = loc.Location();

bool serviceEnabled = await location.serviceEnabled();

if (!serviceEnabled) {
  serviceEnabled = await location.requestService(); // 🔥 THIS SHOWS SYSTEM POPUP

  if (!serviceEnabled) {
    setState(() {
      address = "Location is Off";
      showLocationButton = true;
    });
    print("❌ GPS STILL OFF");
    return;
  }
}

LocationPermission permission = await Geolocator.checkPermission();

// 🔥 FIRST TIME REQUEST
if (permission == LocationPermission.denied) {
  permission = await Geolocator.requestPermission();
}

// ❌ STILL DENIED
if (permission == LocationPermission.denied) {
  setState(() {
    address = "Enable Location";
  });
  return;
}

// ❌ DENIED FOREVER
if (permission == LocationPermission.deniedForever) {
  setState(() {
    address = "Enable location in settings";
  });

  await Geolocator.openAppSettings();
  return;
}

  // ✅ GET POSITION
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  print("✅ LAT: ${position.latitude}, LNG: ${position.longitude}");

  // ✅ GET ADDRESS
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  print("✅ PLACEMARK FETCHED");

Placemark place = placemarks.first;

String shortAddress = "${place.subLocality}, ${place.locality}";
List<String?> addressParts = [
  place.street,
  place.subLocality,
  place.locality,
  place.subAdministrativeArea,
  place.administrativeArea,
  place.postalCode,
  place.country,
];

addressParts = addressParts
    .where((e) => e != null && e.isNotEmpty && !e.contains('+'))
    .toSet()
    .toList();

String fullAddress = addressParts.cast<String>().join(", ");

setState(() {
  address = fullAddress;
  showLocationButton = false;
});

  print("📍 ADDRESS: $fullAddress");

  // ✅ GET USER
  final user = FirebaseAuth.instance.currentUser;
  print("👤 USER: $user");

  if (user != null) {
    print("💾 SAVING TO DB...");

    final dbRef = FirebaseDatabase.instance.ref("users/${user.uid}");

    await dbRef.update({
      "address": fullAddress,
      "lat": position.latitude,
      "lng": position.longitude,
    });

    print("✅ SAVED SUCCESS");
  } else {
    print("❌ USER NULL → NOT SAVED");
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: showLocationButton
    ? Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF4361EE),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
child: Row(
  children: [
    const Icon(Icons.location_on, color: Colors.white),
    const SizedBox(width: 10),
    const Expanded(
      child: Text(
        "Enable location for better results.",
        style: TextStyle(color: Colors.white),
      ),
    ),

    // 🔥 DENY BUTTON (ADDED ONLY THIS)
    TextButton(
      onPressed: () {
        setState(() {
          showLocationButton = false;
        });
      },
      child: const Text(
        "DENY",
        style: TextStyle(color: Colors.white),
      ),
    ),

    ElevatedButton(
      onPressed: getLocation,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      child: const Text(
        "GRANT",
        style: TextStyle(color: Colors.black),
      ),
    )
  ],
),
      )
    : null,
      //drawer: _buildDrawer(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
//leading: Builder(
  //builder: (context) => IconButton(
    //icon: const Icon(Icons.menu_rounded, color: Colors.black87),
    //iconSize: 28,
   // onPressed: () {
   //   Scaffold.of(context).openDrawer(); // 🔥 opens drawer
   // },
  //),
//),
title: Row(
  children: [
    const Icon(
      Icons.location_on_rounded,
      size: 20,
      color: Color(0xFF4361EE),
    ),
    const SizedBox(width: 6),

    // 👇 ONLY THIS PART IS FLEXIBLE
    Expanded(
      child: GestureDetector(
        onTap: showLocationButton ? getLocation : null,
        child: Row(
          mainAxisSize: MainAxisSize.min, // 🔥 IMPORTANT
          children: [
            Flexible(
              child: Text(
                showLocationButton ? "Enable Location" : address,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF111827),
                ),
              ),
            ),

            const SizedBox(width: 4),

            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: Color(0xFF4361EE),
            ),
          ],
        ),
      ),
    ),
  ],
),
        actions: [
Padding(
  padding: const EdgeInsets.only(right: 16),
  child: GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AccountScreen(), // 👈 your account page
        ),
      );
    },
    child: CircleAvatar(
      radius: 20,
      backgroundColor: const Color(0xFFF3F4F6),
      child: const Icon(Icons.person_outline_rounded, size: 24, color: Colors.black87),
    ),
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
              const UrgencyTimerAd(),
              const SizedBox(height: 20),
              const SearchBarWidget(),
              const SizedBox(height: 24),

              // 2. Promotional Offer Card
              const OfferCard(),
              const SizedBox(height: 32),

              // 3. Categories (Circular Professional Design)
              const CategoriesSection(), // Added back as requested
              const SizedBox(height: 32),

              // 6. Bottom spacing for navigation bar clarity
              const SizedBox(height: 32),

              // THE HELP & SUPPORT SECTION
              const PackageSection(),

              const SizedBox(height: 32),
              // 4. Recommended Section Hea
              // der
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
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ServicesScreen(
          categoryName: "All Services",
          categoryId: "all",
        ),
      ),
    );
  },
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
loadingServices
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
          rating: service["rating"].toString(),
          duration: service["duration"] ?? "",
          price: service["price"].toString(),
          imageUrl: service["image"] ?? "",
        );
      }).toList(),
    ),


              // 7. Bottom spacing for navigation bar clarity
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
     // bottomNavigationBar: _buildBottomNav(context),
    );
  }

Widget _buildBottomNav(BuildContext context) {
  return Container(
    height: 68, // 👈 slightly reduced (75 → 68)
    padding: const EdgeInsets.symmetric(horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(44), // 👈 slightly reduced
        topRight: Radius.circular(44),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.045),
          blurRadius: 10,
          offset: const Offset(0, -2),
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [

        _navItem(
          icon: Icons.electrical_services,
          label: "Electrical",
          color: Colors.black54,
          onTap: () {},
        ),

        _navItem(
          icon: Icons.plumbing,
          label: "Plumbing",
          color: Colors.black54,
          onTap: () {},
        ),

        // 🔥 CENTER OFFER (slightly adjusted, still big)
        Transform.translate(
          offset: const Offset(0, -5), // 👈 slightly less lift
          child: GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(11), // 👈 slightly smaller
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFA500),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFFA500).withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      )
                    ],
                  ),
                  child: const Icon(
                    Icons.local_offer,
                    color: Colors.white,
                    size: 26, // 👈 slightly smaller
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  "Offers",
                  style: TextStyle(
                    fontSize: 10.5, // 👈 slight reduction
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFA500),
                  ),
                ),
              ],
            ),
          ),
        ),

        _navItem(
          icon: Icons.carpenter,
          label: "Carpentry",
          color: Colors.black54,
          onTap: () {},
        ),

        _navItem(
          icon: Icons.format_paint,
          label: "Painting",
          color: Colors.black54,
          onTap: () {},
        ),
      ],
    ),
  );
}

Widget _navItem({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required Color color,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 22, color: color), // 👈 24 → 22
        const SizedBox(height: 3),
        Text(
          label,
          style: TextStyle(
            fontSize: 10.5, // 👈 11 → 10.5
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    ),
  );
}
   Widget _buildDrawer(BuildContext context) {
  return Drawer(
    backgroundColor: Colors.white,
    child: SafeArea(
      child: Column(
        children: [
          // 🔥 TOP PROFILE SECTION
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF4361EE),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.black87),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Sunny Samuel",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "sunny@email.com",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 MENU ITEMS
          _drawerItem(Icons.home_rounded, "Home", () {
            Navigator.pop(context);
          }),

          _drawerItem(Icons.miscellaneous_services_rounded, "Services", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ServicesScreen(
                  categoryName: "All Services",
                  categoryId: "all",
                ),
              ),
            );
          }),

          _drawerItem(Icons.person_outline, "My Account", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccountScreen(),
              ),
            );
          }),

          _drawerItem(Icons.history, "Bookings", () {}),

          _drawerItem(Icons.support_agent, "Support", () {}),

          const Spacer(),

          // 🔥 LOGOUT
          Padding(
            padding: const EdgeInsets.all(16),
            child: _drawerItem(Icons.logout, "Logout", () {
              Navigator.pop(context);
              // add logout logic here
            }, isLogout: true),
          ),
        ],
      ),
    ),
  );
}

Widget _drawerItem(IconData icon, String title, VoidCallback onTap,
    {bool isLogout = false}) {
  return ListTile(
    leading: Icon(
      icon,
      color: isLogout ? Colors.red : Colors.black87,
    ),
    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: isLogout ? Colors.red : Colors.black87,
      ),
    ),
    onTap: onTap,
  );
}
}

class UrgencyTimerAd extends StatelessWidget {
  const UrgencyTimerAd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9E7), // Light warm yellow
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFFFC107).withOpacity(0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Decorative background circle for "Canva" feel
            Positioned(
              right: -30,
              top: -30,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFFFC107).withOpacity(0.1),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  // Left Side: Icon and Text
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.bolt_rounded, color: Color(0xFFFFA500), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'ELECTRICAL SPECIAL',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFFFFA500),
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Book within 10 hours\nto get 25% OFF',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF111827),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Valid on all electrical repairs',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Right Side: Timer UI & Action
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111827),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '09:59:59',
                          style: GoogleFonts.jetBrainsMono( // Mono font for timer look
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4361EE),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text('Claim Now', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PackageSection extends StatelessWidget {
  const PackageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Service Tier',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF111827),
              ),
            ),
            _buildStatusTag(),
          ],
        ),
        const SizedBox(height: 16),
        
        // 1. Premium Package (Hero Image)
        _buildImageTierCard(
          title: 'Premium Deep Clean',
          price: '129',
          features: ['All Rooms + Sanitization', 'Post-Service Warranty'],
          isRecommended: true,
          tag: 'MOST POPULAR',
          imageUrl: 'https://sweepsouth.com/wp-content/uploads/2024/10/shutterstock_2479566829.jpg', // Image of a clean living room
        ),
        
        const SizedBox(height: 12),
        
        // 2. Essential Package (Hero Image)
        _buildImageTierCard(
          title: 'Essential Maintenance',
          price: '59',
          features: ['Kitchen & Bathroom Focus', 'General Dusting'],
          isRecommended: false,
          imageUrl: 'https://images.unsplash.com/photo-1584622781564-1d987f7333c1?q=80&w=400', // Image of a bathroom/cleaning detail
        ),
      ],
    );
  }



  Widget _buildImageTierCard({
    required String title,
    required String price,
    required List<String> features,
    required String imageUrl,
    bool isRecommended = false,
    String? tag,
  }) {
    return Container(
      width: double.infinity,
      height: 160, // Fixed height for a balanced look
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isRecommended ? const Color(0xFF4361EE) : const Color(0xFFF3F4F6),
          width: isRecommended ? 2 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 1. IMAGE LAYER (Right Aligned with Fade)
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: 180, // Fills a portion of the card
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(imageUrl, fit: BoxFit.cover),
                  // The "Canva Fade" Gradient
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.white,
                          Colors.white.withOpacity(0.0), // Fades image as it gets to the right
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. CONTENT LAYER (Left Aligned)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // Text Side
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isRecommended && tag != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4361EE),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            tag,
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      Text(
                        title,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Key features
                      ...features.take(2).map((feature) => Row(
                            children: [
                              const Icon(Icons.check_circle_rounded, size: 12, color: Color(0xFF10B981)),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  feature,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 12,
                                    color: const Color(0xFF6B7280),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                
                // Price & Action Side
                const Spacer(flex: 1), // Creates space between content and price
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$$price',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 36, // Compact professional button
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isRecommended ? const Color(0xFF4361EE) : const Color(0xFFF3F4F6),
                            foregroundColor: isRecommended ? Colors.white : const Color(0xFF111827),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text('Add', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  

  Widget _buildStatusTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'TAX INCLUDED',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: const Color(0xFF10B981),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class ServiceCardSkeleton extends StatelessWidget {
  const ServiceCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 120,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}