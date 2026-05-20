import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Secure Storage Import Kiya

import 'select_plan.dart'; 

class GymSetupScreen extends StatefulWidget {
  final String? preFilledName;
  final String? preFilledPhone;

  const GymSetupScreen({super.key, this.preFilledName, this.preFilledPhone});

  @override
  State<GymSetupScreen> createState() => _GymSetupScreenState();
}
class _GymSetupScreenState extends State<GymSetupScreen> {
  final TextEditingController gymName = TextEditingController();
  final TextEditingController ownerName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController openingDate = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Secure Storage instance banaya
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  bool loadingUser = true;
  bool locationLoading = false;

  Position? position;
  String selectedLocationText = "";
  String manualLocation = "";

  // Premium Corporate Palette
  final Color primaryColor = const Color(0xFF1E3A8A); 
  final Color accentColor = const Color(0xFF10B981);  
  final Color backgroundColor = const Color(0xFFF8FAFC); 
  final Color textColor = const Color(0xFF0F172A);      

  @override
  void initState() {
    super.initState();
    _loadSecureUserData();
  }

  // SECURE STORAGE SE DATA LOAD KARNE WALA METHOD
  Future<void> _loadSecureUserData() async {
    try {
      // Login/Signup ke time jis bhi key se save kiya tha, woh yahan read hogi
      // Humne standard 'userName' aur 'userPhone' liya hai, agar aapki key alag ho toh change kar lena
      String? savedName = await _secureStorage.read(key: 'userName');
      String? savedPhone = await _secureStorage.read(key: 'userPhone');

      setState(() {
        ownerName.text = savedName ?? "";
        phone.text = savedPhone ?? "";
        loadingUser = false;
      });
    } catch (e) {
      setState(() {
        loadingUser = false;
      });
    }
  }

  // ================= LOCATION =================
  Future<void> getCurrentLocation() async {
    setState(() => locationLoading = true);

    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        showMessage("Location permission denied", isError: true);
        setState(() => locationLoading = false);
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      position = pos;

      List<Placemark> placeMarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);

      Placemark place = placeMarks.first;

      String city = place.locality ?? "";
      String state = place.administrativeArea ?? "";
      String country = place.country ?? "";

      setState(() {
        selectedLocationText = "$city, $state, $country";
        locationController.text = selectedLocationText;
      });

      showMessage("Location fetched accurately! 📍", isError: false);
    } catch (e) {
      showMessage("Location error: $e", isError: true);
    } finally {
      if (mounted) setState(() => locationLoading = false);
    }
  }

  // ================= PROCEED TO PLAN SELECTION =================
  void proceedToPlanSelection() {
    if (gymName.text.trim().isEmpty ||
        ownerName.text.trim().isEmpty ||
        phone.text.trim().isEmpty ||
        openingDate.text.trim().isEmpty) {
      showMessage("Please fill all required fields", isError: true);
      return;
    }

    if ((position == null || position!.latitude == 0) &&
        manualLocation.trim().isEmpty) {
      showMessage("Please specify or fetch your location", isError: true);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlanSelectionScreen(
          gymName: gymName.text.trim(),
          ownerName: ownerName.text.trim(),
          phone: phone.text.trim(),
          openingDate: openingDate.text.trim(),
          latitude: position?.latitude,
          longitude: position?.longitude,
          locationName: manualLocation.isNotEmpty
              ? manualLocation.trim()
              : selectedLocationText.replaceAll("📍", "").trim(),
        ),
      ),
    );
  }

  // ================= DATE PICKER =================
  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              onPrimary: Colors.white,
              onSurface: textColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        openingDate.text = picked.toIso8601String().split("T")[0];
      });
    }
  }

  void showMessage(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Expanded(child: Text(msg, style: const TextStyle(fontWeight: FontWeight.w500))),
          ],
        ),
        backgroundColor: isError ? Colors.redAccent : accentColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(15),
      ),
    );
  }

  @override
  void dispose() {
    gymName.dispose();
    ownerName.dispose();
    phone.dispose();
    openingDate.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (loadingUser) {
      return Scaffold(
        backgroundColor: backgroundColor,
        body: Center(child: CircularProgressIndicator(color: primaryColor)),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Setup Your Gym",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gym Information",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                    ),
                    const SizedBox(height: 18),

                    _buildField(
                      controller: gymName,
                      label: "Gym Name",
                      prefixIcon: Icons.fitness_center_rounded,
                    ),
                    const SizedBox(height: 16),

                    _buildField(
                      controller: ownerName,
                      label: "Owner Full Name",
                      prefixIcon: Icons.badge_outlined,
                    ),
                    const SizedBox(height: 16),

                    _buildField(
                      controller: phone,
                      label: "Business Phone Number",
                      prefixIcon: Icons.phone_callback_rounded,
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: pickDate,
                      child: AbsorbPointer(
                        child: _buildField(
                          controller: openingDate,
                          label: "Opening Date",
                          prefixIcon: Icons.calendar_today_rounded,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text(
                      "Location Settings",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
                    ),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selectedLocationText.isNotEmpty ? accentColor.withOpacity(0.4) : Colors.grey.withOpacity(0.15),
                          width: 1.5
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: OutlinedButton.icon(
                              onPressed: getCurrentLocation,
                              style: OutlinedButton.styleFrom(
                                backgroundColor: locationLoading ? Colors.grey.withOpacity(0.1) : primaryColor.withOpacity(0.05),
                                side: BorderSide(color: primaryColor.withOpacity(0.2)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                foregroundColor: primaryColor,
                              ),
                              icon: locationLoading
                                  ? SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(color: primaryColor, strokeWidth: 2),
                                    )
                                  : const Icon(Icons.gps_fixed_rounded, size: 18),
                              label: Text(
                                locationLoading ? "Fetching Coordinates..." : "Use Live GPS Location",
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          _buildField(
                            controller: locationController,
                            label: "Or Enter City / Area Manually",
                            prefixIcon: Icons.map_outlined,
                            onChanged: (val) {
                              manualLocation = val;
                              setState(() {
                                selectedLocationText = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: proceedToPlanSelection,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 2,
                          shadowColor: primaryColor.withOpacity(0.3),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "NEXT",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: textColor.withOpacity(0.5), fontSize: 13),
        floatingLabelStyle: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        prefixIcon: Icon(prefixIcon, color: textColor.withOpacity(0.4), size: 20),
        filled: true,
        fillColor: backgroundColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 1.8),
        ),
      ),
    );
  }
}