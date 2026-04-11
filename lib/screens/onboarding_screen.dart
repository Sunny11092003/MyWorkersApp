import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class ProfessionalOnboardingScreen extends StatefulWidget {
  const ProfessionalOnboardingScreen({super.key});

  @override
  State<ProfessionalOnboardingScreen> createState() => _ProfessionalOnboardingScreenState();
}

class _ProfessionalOnboardingScreenState extends State<ProfessionalOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Matching HomeScreen Palette
  final Color primaryBlue = const Color(0xFF4361EE);
  final Color darkGrey = const Color(0xFF111827);
  final Color bodyText = const Color(0xFF6B7280);

  final List<Map<String, String>> _pages = [
    {
      "title": "Professional Home Care Services",
      "desc": "High-quality electrical, plumbing, and cleaning fixes at your fingertips.",
      "image": "https://techsquadteam.com/assets/profile/blogimages/9ee372ea2e007c87b293c5e5a9fea6a0.png",
    },
    {
      "title": "Verified Master Professionals",
      "desc": "Premium carpentry and painting services handled by industry experts.",
      "image": "https://media.istockphoto.com/id/2205544490/photo/plumber-installing-water-filter-system-under-kitchen-sink.jpg?s=612x612&w=0&k=20&c=Tfo_qXb9Rcc604LBKYdD-nZBGspr7cAE45f4FEHd6Hs=",
    },
    {
      "title": "Instant Help at Your Doorstep",
      "desc": "The fastest and most reliable way to get professional help today.",
      "image": "https://dioncomfort.com/wp-content/uploads/2024/10/ac-repair.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => _finishOnboarding(),
            child: Text(
              "Skip",
              style: GoogleFonts.plusJakartaSans(
                color: bodyText,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // 1. Image Stage (Clean & High-End)
          Expanded(
            flex: 5,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (val) => setState(() => _currentIndex = val),
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      )
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(
                      _pages[index]["image"]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),

          // 2. Info Section (Matching HomeScreen Typography)
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  // Dot Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildDot(index),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Text(
                    _pages[_currentIndex]["title"]!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: darkGrey,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _pages[_currentIndex]["desc"]!,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      color: bodyText,
                      height: 1.6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  const Spacer(),

                  // Primary Button (Matching "Claim Now" Style)
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentIndex < _pages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeOutQuart,
                          );
                        } else {
                          _finishOnboarding();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        _currentIndex == _pages.length - 1 ? "GET STARTED" : "CONTINUE",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Widget _buildDot(int index) {
    bool isSelected = _currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: isSelected ? 24 : 6,
      decoration: BoxDecoration(
        color: isSelected ? primaryBlue : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}