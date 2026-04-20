import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _houseController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _directionsController = TextEditingController();

  LatLng _selectedLocation = const LatLng(12.9716, 77.5946);
  String _displayAddress = "Select your location on map";
  bool _isLocationSet = false;

  // Modern Professional Palette
  final Color primaryBlue = const Color(0xFF4361EE);
  final Color darkGrey = const Color(0xFF111827);
  final Color bodyText = const Color(0xFF6B7280);
  final Color fieldFill = const Color(0xFFF9FAFB);

  String _selectedLabel = "Home";

  void _showError(String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(msg)),
  );
}

void _saveAddress() {
  if (!_isLocationSet) {
    _showError("Please select location on map");
    return;
  }

  if (_houseController.text.isEmpty ||
      _floorController.text.isEmpty ||
      _buildingController.text.isEmpty ||
      _landmarkController.text.isEmpty ||
      _directionsController.text.isEmpty) {
    _showError("All fields are required");
    return;
  }

  _saveToFirebase();
}

Future<void> _saveToFirebase() async {
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    _showError("User not logged in");
    return;
  }

  DatabaseReference ref = FirebaseDatabase.instance
      .ref("users/${user.uid}/saved_address")
      .push();

  await ref.set({
    "house": _houseController.text,
    "floor": _floorController.text,
    "building": _buildingController.text,
    "landmark": _landmarkController.text,
    "directions": _directionsController.text,
    "latitude": _selectedLocation.latitude,
    "longitude": _selectedLocation.longitude,
    "address": _displayAddress,
    "label": _selectedLabel,
    "timestamp": DateTime.now().toString(),
  });

  Navigator.pop(context);
}


Future<void> _getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    _showError("Enable location services");
    return;
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }

  if (permission == LocationPermission.deniedForever) {
    _showError("Location permission denied permanently");
    return;
  }

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  LatLng current = LatLng(position.latitude, position.longitude);

  setState(() => _selectedLocation = current);

  _mapController.move(current, _mapController.camera.zoom);

  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        current.latitude, current.longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      setState(() {
        _displayAddress = "${place.name}, ${place.locality}";
        _isLocationSet = true;
      });
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: darkGrey, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // 1. Full Screen Map Layer
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedLocation,
              initialZoom: 15,
              onTap: (tapPosition, point) async {
                setState(() => _selectedLocation = point);
                try {
                  List<Placemark> placemarks = await placemarkFromCoordinates(
                      point.latitude, point.longitude);
                  if (placemarks.isNotEmpty) {
                    Placemark place = placemarks.first;
                    setState(() {
                      _displayAddress = "${place.name}, ${place.locality}";
                      _isLocationSet = true;
                    });
                  }
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png",
                subdomains: const ['a', 'b', 'c', 'd'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedLocation,
                    width: 60,
                    height: 60,
                    child: Icon(Icons.location_on_rounded, size: 45, color: primaryBlue),
                  ),
                ],
              ),
            ],
          ),

          // 2. Draggable Form Layer
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.15,
            maxChildSize: 0.9,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle bar
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      
                      Text(
                        _isLocationSet ? "Confirm Details" : "Set Delivery Location",
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: darkGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Status/Location Text
                      Row(
                        children: [
                          Icon(Icons.near_me, size: 14, color: primaryBlue),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _displayAddress,
                              style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: bodyText,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

TextButton.icon(
  onPressed: _getCurrentLocation,
  icon: Icon(Icons.my_location, color: primaryBlue),
  label: Text(
    "Use Current Location",
    style: TextStyle(color: primaryBlue),
  ),
),
                      
                      const SizedBox(height: 30),

                      // Input Fields Grouped
                      Row(
                        children: [
                          Expanded(child: _buildField("FLAT / HOUSE", _houseController, "No. 12")),
                          const SizedBox(width: 12),
                          Expanded(child: _buildField("FLOOR", _floorController, "3rd Floor")),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildField("BUILDING / STREET", _buildingController, "Shanti Villa"),
                      const SizedBox(height: 16),
                      _buildField("LANDMARK", _landmarkController, "Near Green Park"),
                      const SizedBox(height: 16),
                      _buildField("DIRECTIONS", _directionsController, "Gate entry from North side", maxLines: 2),

                      const SizedBox(height: 24),
                      Text(
                        "SAVE AS",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: bodyText,
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _chip("Home", Icons.home_filled),
                          const SizedBox(width: 8),
                          _chip("Work", Icons.work_rounded),
                          const SizedBox(width: 8),
                          _chip("Other", Icons.location_on),
                        ],
                      ),
                      const SizedBox(height: 32),
                      
                      _buildConfirmButton(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: darkGrey.withOpacity(0.6),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: bodyText.withOpacity(0.3), fontSize: 13),
            filled: true,
            fillColor: fieldFill,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _chip(String label, IconData icon) {
    bool isSelected = _selectedLabel == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedLabel = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? darkGrey : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? darkGrey : Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isSelected ? Colors.white : bodyText),
            const SizedBox(width: 6),
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: isSelected ? Colors.white : bodyText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: _saveAddress,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          elevation: 0,
        ),
        child: Text(
          "CONFIRM AND SAVE",
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ),
    );
  }
}
