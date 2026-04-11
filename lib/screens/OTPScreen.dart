import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final Color primaryBlue = const Color(0xFF4361EE);
  final Color darkGrey = const Color(0xFF111827);
  final Color bodyText = const Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: darkGrey), // Swiggy style close button
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // 1. Header Text
                Text(
                  "Enter 6-digit code",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: darkGrey,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Sent to +91 98765 43210",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    color: bodyText,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 48),

                // 2. Minimalist OTP Inputs (Urban Company Style)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 45,
                      child: TextField(
                        autofocus: index == 0,
                        onChanged: (value) {
                          if (value.length == 1 && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                          if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: darkGrey,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryBlue, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                // 3. Resend Action
                Row(
                  children: [
                    Text(
                      "Expecting code in ",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: bodyText,
                      ),
                    ),
                    Text(
                      "00:24",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        color: darkGrey,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // 4. Proceed Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
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
                      "Verify & Proceed",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}