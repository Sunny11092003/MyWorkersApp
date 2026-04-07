import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'booking_screen.dart';
import 'profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    BookingScreen(serviceTitle: '', price: '', imageAsset: '', scheduledDateTime: DateTime.now(),),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF4361EE),
            unselectedItemColor: Colors.grey.shade400,
            selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.home_outlined, size: 28)),
                activeIcon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.home, size: 28)),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.calendar_today_outlined, size: 26)),
                activeIcon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.calendar_month, size: 26)),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.person_outline, size: 28)),
                activeIcon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.person, size: 28)),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}