import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditCardItem extends StatelessWidget {
  final bool isVisa;
  final String cardHolder;
  final String expiry;
  final String lastFour;

  const CreditCardItem({
    super.key,
    required this.isVisa,
    required this.cardHolder,
    required this.expiry,
    required this.lastFour,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: isVisa 
            ? const LinearGradient(
                colors: [Color(0xFF2A51FB), Color(0xFF4232F0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : const LinearGradient(
                colors: [Color(0xFF0B0C1A), Color(0xFF13152A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: (isVisa ? const Color(0xFF2A51FB) : const Color(0xFF0B0C1A)).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // NFC Icon
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.wifi_tethering, color: Colors.white, size: 20),
              ),
              // Card Type Logo
              if (isVisa)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'VISA',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'PREMIUM',
                      style: GoogleFonts.poppins(color: Colors.white70, fontSize: 10, letterSpacing: 1),
                    )
                  ],
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 30,
                      child: Stack(
                        children: [
                          Positioned(left: 0, child: Container(width: 30, height: 30, decoration: BoxDecoration(color: const Color(0xFFEB001B).withOpacity(0.8), shape: BoxShape.circle))),
                          Positioned(right: 0, child: Container(width: 30, height: 30, decoration: BoxDecoration(color: const Color(0xFFF79E1B).withOpacity(0.8), shape: BoxShape.circle))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'WORLD ELITE',
                      style: GoogleFonts.poppins(color: Colors.white38, fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
            ],
          ),
          
          // Card Number
          Row(
            children: [
              _buildDots(),
              const SizedBox(width: 16),
              _buildDots(),
              const SizedBox(width: 16),
              _buildDots(),
              const SizedBox(width: 16),
              Text(
                lastFour,
                style: GoogleFonts.sourceCodePro(
                  color: Colors.white,
                  fontSize: 22,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          // Footer Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CARD HOLDER', style: GoogleFonts.poppins(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w600)),
                  Text(cardHolder.toUpperCase(), style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('EXPIRES', style: GoogleFonts.poppins(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w600)),
                  Text(expiry, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      children: List.generate(4, (index) => Container(
        margin: const EdgeInsets.only(right: 6),
        width: 6,
        height: 6,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      )),
    );
  }
}