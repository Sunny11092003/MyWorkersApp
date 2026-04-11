import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  // Global Brand Palette from Home
  final Color _primaryBlue = const Color(0xFF4361EE);
  final Color _textDark = const Color(0xFF111827);
  final Color _textLight = const Color(0xFF6B7280);
  final Color _scaffoldBg = const Color(0xFFF3F4F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _scaffoldBg,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildProfileCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildPlusBanner(),
                  const SizedBox(height: 32),
                  
                  _buildSectionLabel("MY SERVICES"),
                  _buildActionGroup([
                    _actionTile(Icons.calendar_today_rounded, "My Bookings", "Ongoing and past services"),
                    _actionTile(Icons.auto_awesome_motion_rounded, "Manage Subscriptions", "Active plans", isNew: true),
                    _actionTile(Icons.wallet_giftcard_rounded, "My Rating & Reviews", "Feedback shared"),
                  ]),
                  
                  const SizedBox(height: 24),
                  _buildSectionLabel("PAYMENTS & WALLET"),
                  _buildActionGroup([
                    _actionTile(Icons.account_balance_wallet_outlined, "My Wallet", "Current balance: ₹450"),
                    _actionTile(Icons.payment_rounded, "Saved Methods", "Cards and UPI"),
                    _actionTile(Icons.confirmation_number_outlined, "Offers & Coupons", "View available discounts"),
                  ]),
                  
                  const SizedBox(height: 24),
                  _buildSectionLabel("SETTINGS & SUPPORT"),
                  _buildActionGroup([
                    _actionTile(Icons.location_on_outlined, "Manage Addresses", "Home, Office & others"),
                    _actionTile(Icons.help_outline_rounded, "Help Center", "24/7 Support"),
                    _actionTile(Icons.info_outline_rounded, "About Company", "Policy and terms"),
                  ]),
                  
                  const SizedBox(height: 32),
                  _buildLogoutButton(),
                  
                  const SizedBox(height: 40),
                  _buildBranding(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: _textDark, size: 20),
      ),
      title: Text(
        "Account",
        style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w800,
          fontSize: 16,
          color: _textDark,
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: _scaffoldBg,
            child: Icon(Icons.person_rounded, color: _primaryBlue, size: 40),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Aatish Chetan",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: _textDark,
                  ),
                ),
                Text(
                  "aatish@froinex.com • +91 9876543210",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: _textLight,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit_note_rounded, color: _primaryBlue, size: 26),
          )
        ],
      ),
    );
  }

  Widget _buildPlusBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1E1E), Color(0xFF3D3D3D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Color(0xFFFFA500), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "PLUS MEMBERSHIP",
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "Save 15% on every service",
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Text("Join", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800)),
          )
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8, bottom: 12),
        child: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF9CA3AF),
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }

  Widget _buildActionGroup(List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(children: items),
    );
  }

  Widget _actionTile(IconData icon, String title, String subtitle, {bool isNew = false}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: _primaryBlue.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: _primaryBlue, size: 20),
      ),
      title: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          if (isNew) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                "NEW",
                style: TextStyle(color: Colors.orange, fontSize: 8, fontWeight: FontWeight.bold),
              ),
            )
          ]
        ],
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.plusJakartaSans(fontSize: 11, color: _textLight),
      ),
      trailing: Icon(Icons.chevron_right_rounded, size: 18, color: _textLight.withOpacity(0.5)),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.redAccent.withOpacity(0.1)),
          ),
          backgroundColor: Colors.white,
        ),
        child: Text(
          "Log Out",
          style: GoogleFonts.plusJakartaSans(
            color: Colors.redAccent,
            fontWeight: FontWeight.w800,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildBranding() {
    return Column(
      children: [
        const SizedBox(height: 4),
        Text(
          "App Version 1.0.4",
          style: GoogleFonts.plusJakartaSans(fontSize: 10, color: _textLight.withOpacity(0.5)),
        ),
      ],
    );
  }
}