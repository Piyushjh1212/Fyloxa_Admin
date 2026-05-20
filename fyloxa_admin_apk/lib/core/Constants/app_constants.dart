import 'package:flutter/material.dart';

class CountryModel {
  final String name;
  final String dialCode;
  final String flag;
  final int minLength;
  final int maxLength;

  CountryModel(this.name, this.dialCode, this.flag, this.minLength, this.maxLength);
}

class AppConstants {
  // 1. Brand Colors 
  static const Color primaryColor = Color(0xFF1E3A8A);     // Deep Royal Blue
  static const Color accentColor = Color(0xFF10B981);      // Emerald Green
  static const Color backgroundColor = Color(0xFFF8FAFC);  // Soft Grey/White
  static const Color textColor = Color(0xFF0F172A);        // Dark Slate
  static const Color errorColor = Colors.redAccent;

  // 2. App Information
  static const String appName = "Fyloxa Admin";
  static const String appVersion = "1.0.0";

  // 3. APP STRINGS (Labels/Titles)
  static const String gymSetupTitle = "Setup Your Gym";
  static const String gymNameLabel = "Gym Name";
  static const String ownerNameLabel = "Owner Full Name";
  static const String phoneLabel = "Business Phone Number";
  static const String openingDateLabel = "Opening Date";
  static const String locationManualLabel = "Or Enter City / Area Manually";
  static const String nextButton = "NEXT";
  
  // 4. Padding aur Margins (UI Consistency ke liye)
  static const double paddingXS = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;  // Sabse zyada use hone wali padding
  static const double paddingLarge = 24.0;
  static const double paddingXL = 32.0;

  // 5. Border Radius (Card aur Buttons ke kone)
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 14.0; // Jo aapne input field me use kiya
  static const double borderRadiusLarge = 24.0;  // Jo aapne container card me use kiya
  static const double borderRadiusButton = 16.0;
  static const double paddingStandard = 24.0;

  // 6. Database/Shared Preferences Keys
  static const String keyAuthToken = "user_auth_token";
  static const String keyIsLoggedIn = "is_user_logged_in";
  static const String keyGymId = "registered_gym_id";
  static const String keyThemeMode = "app_theme_mode";

  // 7. Validation Rules (Regex aur Limits) - [UPDATED]
  static const int passwordMinLength = 6; // Humne UI me 6 rakha hai, toh ise 6 kar diya
  static const int phoneNumberLength = 10;
  
  
  // 8. Pattern Strings
  static const String emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String phonePattern = r'^[6-9]\d{9}$';

  // 9. Direct RegExp Objects (UI me validation fast karne ke liye)
  static final RegExp emailRegex = RegExp(emailPattern);
  static final RegExp phoneRegex = RegExp(phonePattern);

  // 10. Pagination & UX Defaults
  static const int membersPageLimit = 20; // Ek baar me kitne members list me load honge
  static const int snackbarDurationInSeconds = 4;

  // 11. UI Strings (Auth & Screens) - [NEW SECTION]
  static const String registerTitle = "Create Account";
  static const String registerSubtitle = "Join the Fyloxa Admin Workspace";
  static const String successRegisterMsg = "Account created successfully! 🎉";

  // 12. Dynamic Country List (Common countries for better UX)
  static final List<CountryModel> countryList = [
    CountryModel("India", "+91", "🇮🇳", 10, 10),
    CountryModel("USA", "+1", "🇺🇸", 10, 10),
    CountryModel("UK", "+44", "🇬🇧", 10, 11),
    CountryModel("Canada", "+1", "🇨🇦", 10, 10),
    CountryModel("UAE", "+971", "🇦🇪", 9, 9),
    CountryModel("Australia", "+61", "🇦🇺", 9, 9),
    CountryModel("Saudi", "+966", "🇸🇦", 9, 9),
    // Aap is list ko jitna chahe bada sakte hain...
  ];

  // Default Country
  static final CountryModel defaultCountry = countryList[0];
}