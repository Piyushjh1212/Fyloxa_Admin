import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key, 
    required this.controller, 
    required this.hintText, 
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // Shuruat mein password hamesha hidden rahega
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      // Agar password field hai toh toggle state chalegi, warna false (hamesha dikhega)
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      style: const TextStyle(color: Color(0xFF0F172A), fontSize: 15),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
        filled: true,
        fillColor: Colors.white, // Modern Premium White Box Look
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        // Normal state border (Subtle Grey)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
        // Clicking state border (Premium Blue Accent)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
        ),
        // Error border layout
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        // Eye icon sirf tabhi dikhega jab widget.isPassword true hoga
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: const Color(0xFF64748B),
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Toggle show/hide
                  });
                },
              )
            : null,
      ),
    );
  }
}