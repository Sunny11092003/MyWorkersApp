import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String currentPhone;

  const EditProfileScreen({
    super.key,
    required this.currentName,
    required this.currentEmail,
    required this.currentPhone,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final Color primaryBlue = const Color(0xFF4361EE);
  final Color textDark = const Color(0xFF111827);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentName);
    _emailController = TextEditingController(text: widget.currentEmail);
    _phoneController = TextEditingController(text: widget.currentPhone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // Pass the updated data back to the Profile Screen
    Navigator.pop(context, {
      'name': _nameController.text,
      'email': _emailController.text,
      'phone': _phoneController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            color: textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Editable Avatar
            Stack(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryBlue.withOpacity(0.2), width: 3),
                  ),
                  child: Center(
                    child: Text(
                      _nameController.text.isNotEmpty 
                          ? _nameController.text.substring(0, 2).toUpperCase() 
                          : 'U',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      // Action to pick image from gallery
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: primaryBlue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Form Fields
            _buildTextField("Full Name", Icons.person_outline, _nameController),
            const SizedBox(height: 20),
            _buildTextField("Email Address", Icons.email_outlined, _emailController),
            const SizedBox(height: 20),
            _buildTextField("Phone Number", Icons.phone_outlined, _phoneController, isNumber: true),
            
            const SizedBox(height: 40),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: textDark,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey[500]),
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: primaryBlue, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }
}