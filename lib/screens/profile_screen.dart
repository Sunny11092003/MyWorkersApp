import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile_screen.dart';
import 'manage_addresses_screen.dart';
import 'payment_methods_screen.dart';
import '../widgets/profile/stat_card.dart';
import '../widgets/profile/profile_menu_list_tile.dart';
import '../widgets/profile/urban_gold_card.dart';
import '../widgets/profile/referral_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "Alex Rivera";
  String userEmail = "alex.rivera@email.com";
  String userPhone = "+1 234 567 8900";

  Future<void> _navigateToEditProfile() async {
    final updatedData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfileScreen(
          currentName: userName,
          currentEmail: userEmail,
          currentPhone: userPhone,
        ),
      ),
    );

    if (updatedData != null && updatedData is Map<String, String>) {
      setState(() {
        userName = updatedData['name'] ?? userName;
        userEmail = updatedData['email'] ?? userEmail;
        userPhone = updatedData['phone'] ?? userPhone;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Exact colors extracted from your design
    const Color bgTint = Color(0xFFF9F9FC); // Very subtle purple/grey off-white
    const Color primaryBlue = Color(0xFF3F51F3);
    const Color textDark = Color(0xFF111827);
    const Color textGrey = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: bgTint, 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: primaryBlue),
          onPressed: () {},
        ),
        title: Text(
          'Account',
          style: GoogleFonts.poppins(
            color: textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: primaryBlue),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Column(
          children: [
            // ----------------------------------------
            // Avatar & Name Section
            // ----------------------------------------
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFE0E7FF), width: 4),
                          image: const DecorationImage(
                            image: NetworkImage('https://randomuser.me/api/portraits/men/32.jpg'), // Demo face from screenshot
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _navigateToEditProfile, // Makes the edit pen functional
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: primaryBlue,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.edit, color: Colors.white, size: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userName, // Bound to the state variable
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF7C8DFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.workspace_premium, color: Colors.white, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          'Premium Member',
                          style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Joined Oct 2023',
                    style: GoogleFonts.poppins(color: textGrey, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // ----------------------------------------
            // Stats Row
            // ----------------------------------------
            Row(
              children: const [
                StatCard(value: '42', label: 'TOTAL BOOKINGS'),
                StatCard(value: '\$215', label: 'MONEY SAVED'),
                StatCard(value: '8.4k', label: 'LOYALTY POINTS'),
              ],
            ),
            const SizedBox(height: 32),

            // ----------------------------------------
            // Main Menu List
            // ----------------------------------------
            ProfileMenuListTile(
              icon: Icons.shopping_bag,
              title: 'My Bookings',
              subtitle: 'View all service history',
              onTap: () {
                // Link to Booking Screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const BookingScreen()));
              },
            ),
            ProfileMenuListTile(
              icon: Icons.location_on,
              title: 'Manage Addresses',
              onTap: () {
                // Link to Addresses Screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageAddressesScreen()));
              },
            ),
            ProfileMenuListTile(
              icon: Icons.payments,
              title: 'Payment Methods',
              onTap: () {
                // Link to Payments Screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentMethodsScreen()));
              },
            ),

            const SizedBox(height: 8),
            const UrbanGoldCard(), // The dark blue premium banner
            const SizedBox(height: 24),

            ProfileMenuListTile(
              icon: Icons.support_agent,
              title: 'Help & Support',
              onTap: () {},
            ),
            
            const SizedBox(height: 8),
            const ReferralCard(), // The green referral banner
            const SizedBox(height: 32),

            // ----------------------------------------
            // More Information Section
            // ----------------------------------------
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'MORE INFORMATION',
                style: GoogleFonts.poppins(
                  fontSize: 10, 
                  fontWeight: FontWeight.bold, 
                  letterSpacing: 1.5, 
                  color: textGrey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  _buildInfoTile('About Urban Pulse', Icons.info),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  _buildInfoTile('Privacy Policy', Icons.privacy_tip),
                  const Divider(height: 1, color: Color(0xFFF3F4F6)),
                  _buildInfoTile('Terms of Service', Icons.gavel),
                ],
              ),
            ),

            const SizedBox(height: 32),
            
            // ----------------------------------------
            // Sign Out Button
            // ----------------------------------------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout),
                label: Text(
                  'Sign Out', 
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEDEFFF), // Light purple bg matching design
                  foregroundColor: const Color(0xFFD91E36), // Red text
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Footer text
            Text(
              'APP VERSION 4.12.0 • MADE WITH PULSE',
              style: GoogleFonts.poppins(
                fontSize: 10, 
                fontWeight: FontWeight.bold, 
                letterSpacing: 1, 
                color: const Color(0xFFB0B5C9),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // Helper widget for the bottom list tiles
  Widget _buildInfoTile(String title, IconData icon) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      title: Text(
        title, 
        style: GoogleFonts.poppins(fontSize: 14, color: const Color(0xFF4B5563)),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Color(0xFFEEF2FF), 
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 14, color: const Color(0xFF8B98DB)),
      ),
      onTap: () {},
    );
  }
}