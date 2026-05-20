import 'package:flutter/material.dart';

class CustomLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child, // Main Screen Content
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3), // Background dim karne ke liye
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
      ],
    );
  }
}