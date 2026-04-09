import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageAddressesScreen extends StatelessWidget {
  const ManageAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Exact colors from the UI
    const Color bgTint = Color(0xFFF6F6FA); // Light lavender/grey background
    const Color textDark = Color(0xFF1C1C36); // Dark navy for headers
    const Color textGrey = Color(0xFF6B7280); // Grey for subtitles
    const Color primaryBlue = Color(0xFF5A6BF2); // Main blue color

    return Scaffold(
      backgroundColor: bgTint,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Manage Addresses',
          style: GoogleFonts.poppins(
            color: textDark,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 200), // Padding for bottom UI
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  'Saved Locations',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: textDark,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your pulse, your places. Manage\nwhere you need Urban Pulse to meet\nyou.',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: textGrey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // Address Cards
                _AddressLocationCard(
                  icon: Icons.home,
                  iconBgColor: primaryBlue,
                  iconColor: Colors.white,
                  title: 'Home',
                  addressLine1: '482 Kinetic Avenue, Apt 12C',
                  addressLine2: 'Neo City Central, 10024',
                  isDefault: true,
                ),
                _AddressLocationCard(
                  icon: Icons.work,
                  iconBgColor: const Color(0xFFDCDFFF), // Light blue pastel
                  iconColor: primaryBlue,
                  title: 'Office',
                  addressLine1: 'Pulse Tower, 88 Velocity Way',
                  addressLine2: 'Financial District',
                  isDefault: false,
                ),
                _AddressLocationCard(
                  icon: Icons.fitness_center,
                  iconBgColor: const Color(0xFFDCDFFF),
                  iconColor: primaryBlue,
                  title: 'The Forge Gym',
                  addressLine1: '92 Iron Street, Unit 4',
                  addressLine2: 'East Industrial Side',
                  isDefault: false,
                ),
              ],
            ),
          ),

          // Bottom Section (Recent Activity & Add Button)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    bgTint.withOpacity(0.0),
                    bgTint.withOpacity(0.8),
                    bgTint,
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Recent Activity Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: primaryBlue.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'RECENT ACTIVITY',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: primaryBlue,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              '2 mins ago',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: textGrey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/lego/2.jpg'), // Avatar placeholder matching Na'vi look
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Deliveries near 'Home'",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: LinearProgressIndicator(
                                      value: 0.65,
                                      backgroundColor: const Color(0xFFE0E7FF),
                                      color: primaryBlue,
                                      minHeight: 6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Add New Address Button
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3F51F3), Color(0xFF7A85FF)], // Vibrant blue gradient
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryBlue.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add, color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Add New Address',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
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

// --------------------------------------------------------
// Custom Widget for the Address Cards
// --------------------------------------------------------
class _AddressLocationCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String addressLine1;
  final String addressLine2;
  final bool isDefault;

  const _AddressLocationCard({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.addressLine1,
    required this.addressLine2,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    const Color textDark = Color(0xFF1C1C36);
    const Color textGrey = Color(0xFF6B7280);
    const Color primaryBlue = Color(0xFF5A6BF2);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: textDark.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Icon and Actions
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (isDefault) // Add a soft glow to the blue home icon
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                  ],
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const Spacer(),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.edit, color: Color(0xFF4B5563), size: 20),
                onPressed: () {},
              ),
              const SizedBox(width: 16),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.delete, color: Color(0xFFD91E36), size: 20),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Address Info
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            addressLine1,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: textGrey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            addressLine2,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: textGrey,
            ),
          ),
          
          // Default Delivery Status (Only shows if true)
          if (isDefault) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: primaryBlue,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'DEFAULT DELIVERY',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}