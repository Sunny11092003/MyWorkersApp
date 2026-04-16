import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'OTPScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // Brand Palette (Consistent with your Onboarding)
  final Color primaryBlue = const Color(0xFF4361EE);
  final Color darkGrey = const Color(0xFF111827);
  final Color bodyText = const Color(0xFF6B7280);
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: darkGrey),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        // FIX: Wrapped in SingleChildScrollView to solve the layout constraint error
        child: SingleChildScrollView(
          child: ConstrainedBox(
            // Ensures the content takes at least the full height of the screen for the Spacer to work
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 
                         AppBar().preferredSize.height - 
                         MediaQuery.of(context).padding.top,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    
                    // 1. Image Branding
                    Center(
                      child: Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          image: const DecorationImage(
                            image: NetworkImage("https://img.freepik.com/free-vector/login-concept-illustration_114360-739.jpg"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 2. Bold Title
                    Text(
                      "Ready to fix your home? 🏠",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: darkGrey,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Enter your phone number to continue",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 15,
                        color: bodyText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 3. The "Super-App" Phone Input Box
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                "https://flagcdn.com/w40/in.png",
                                width: 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "+91",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: darkGrey,
                                ),
                              ),
                              Icon(Icons.keyboard_arrow_down, color: bodyText, size: 20),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Container(height: 24, width: 1, color: Colors.grey.shade300),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: darkGrey,
                                letterSpacing: 2,
                              ),
                              decoration: InputDecoration(
                                hintText: "Phone number",
                                hintStyle: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade400,
                                  letterSpacing: 0,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 4. Primary CTA Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
onPressed: () async {
  String phone = phoneController.text.trim();

  if (phone.isEmpty || phone.length < 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Enter valid phone number")),
    );
    return;
  }

  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '+91$phone',

    verificationCompleted: (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
    },

    verificationFailed: (FirebaseAuthException e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Error")),
      );
    },

    codeSent: (String verificationId, int? resendToken) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen(
            verificationId: verificationId,
            phone: phone,
          ),
        ),
      );
    },

    codeAutoRetrievalTimeout: (String verificationId) {},
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
                          "Send OTP",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),

                    const Spacer(),

                    // 5. Legal Text
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "By continuing, you agree to our",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: bodyText,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _footerLink("Terms of Service"),
                              _footerDot(),
                              _footerLink("Privacy Policy"),
                              _footerDot(),
                              _footerLink("Content Policy"),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _footerLink(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        color: darkGrey,
        fontWeight: FontWeight.w600,
        decoration: TextDecoration.underline,
      ),
    );
  }

  Widget _footerDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Icon(Icons.circle, size: 3, color: bodyText),
    );
  }
}