import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Signin.dart';

class ProfessionalOnboardingScreen extends StatefulWidget {
  const ProfessionalOnboardingScreen({super.key});

  @override
  State<ProfessionalOnboardingScreen> createState() => _ProfessionalOnboardingScreenState();
}

class _ProfessionalOnboardingScreenState extends State<ProfessionalOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  bool _isAnimating = false;

  // Your Original Palette
  final Color primaryBlue = const Color(0xFF4361EE);
  final Color darkGrey = const Color(0xFF111827);
  final Color bodyText = const Color(0xFF6B7280);

  final List<Map<String, String>> _pages = [
    {
      "title": "Professional Home\nCare Services",
      "desc": "High-quality electrical, plumbing, and cleaning fixes at your fingertips.",
      "image": "https://techsquadteam.com/assets/profile/blogimages/9ee372ea2e007c87b293c5e5a9fea6a0.png",
    },
    {
      "title": "Verified Master\nProfessionals",
      "desc": "Premium carpentry and painting services handled by industry experts.",
      "image": "https://media.istockphoto.com/id/2205544490/photo/plumber-installing-water-filter-system-under-kitchen-sink.jpg?s=612x612&w=0&k=20&c=Tfo_qXb9Rcc604LBKYdD-nZBGspr7cAE45f4FEHd6Hs=",
    },
    {
      "title": "Instant Help at\nYour Doorstep",
      "desc": "The fastest and most reliable way to get professional help today.",
      "image": "https://dioncomfort.com/wp-content/uploads/2024/10/ac-repair.jpg",
    },
  ];

  @override
  void initState() {
    super.initState();
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_isAnimating) return;
      if (_currentIndex < _pages.length - 1) {
        _moveNext();
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> _moveNext() async {
    if (_isAnimating) return;
    _isAnimating = true;
    await _pageController.nextPage(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutQuart,
    );
    _isAnimating = false;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Content View
          Column(
            children: [
              Expanded(
                flex: 11,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (val) => setState(() => _currentIndex = val),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        // Image Container with Modern Shadow
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  blurRadius: 40,
                                  offset: const Offset(0, 20),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.network(
                                _pages[index]["image"]!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        // Text Content with Smooth Switcher
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              const SizedBox(height: 20),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                child: Text(
                                  _pages[index]["title"]!,
                                  key: ValueKey<int>(index),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: darkGrey,
                                    height: 1.1,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _pages[index]["desc"]!,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  color: bodyText,
                                  height: 1.6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Spacer for the bottom button area
              const Expanded(flex: 3, child: SizedBox()),
            ],
          ),

          // 3. Bottom Controls (Indicator + Button)
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => _buildDot(index),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentIndex < _pages.length - 1) {
                          _moveNext();
                        } else {
                          _finishOnboarding();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        elevation: 10,
                        shadowColor: primaryBlue.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        _currentIndex == _pages.length - 1 ? "GET STARTED" : "CONTINUE",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isSelected = _currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 6,
      width: isSelected ? 24 : 8,
      decoration: BoxDecoration(
        color: isSelected ? primaryBlue : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void _finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }
}