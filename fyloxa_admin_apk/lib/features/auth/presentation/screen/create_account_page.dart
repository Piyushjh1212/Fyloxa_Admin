import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../block/auth_bloc.dart';
import '../../../gym/presentation/screen/gym_setup_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  String completePhoneNumber = ""; 
  String defaultCountryCode = "+91"; // Default India fallback ke liye

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0F172A), size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF0F172A), letterSpacing: -0.5),
              ),

              const SizedBox(height: 32),

              // Full Name Field
              const Text("Full Name", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
              const SizedBox(height: 8),
              CustomTextField(controller: nameController, hintText: 'Enter Your Name'),
              const SizedBox(height: 20),

              // Email Field
              const Text("Email Address", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
              const SizedBox(height: 8),
              CustomTextField(controller: emailController, hintText: 'name@company.com'),
              const SizedBox(height: 20),

              // Premium Country Code + Phone Picker
              const Text("Phone Number", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
              const SizedBox(height: 8),
              IntlPhoneField(
                controller: phoneController,
                initialCountryCode: 'IN', 
                dropdownIconPosition: IconPosition.trailing,
                style: const TextStyle(color: Color(0xFF0F172A), fontSize: 15),
                showDropdownIcon: true,
                disableLengthCheck: true,
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 1.5),
                  ),
                ),
                onCountryChanged: (country) {
                  setState(() {
                    defaultCountryCode = "+${country.dialCode}";
                  });
                },
                onChanged: (phone) {
                  setState(() {
                    completePhoneNumber = phone.completeNumber; // Direct full formatted number save karega
                  });
                },
              ),
              const SizedBox(height: 20),

              // Password Field
              const Text("Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
              const SizedBox(height: 8),
              CustomTextField(controller: passwordController, hintText: 'Create strong password', isPassword: true),
              const SizedBox(height: 20),

              // Confirm Password Field
              const Text("Confirm Password", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
              const SizedBox(height: 8),
              CustomTextField(controller: confirmPasswordController, hintText: 'Repeat your password', isPassword: true),
              const SizedBox(height: 36),

              // Action Button via BlocConsumer
              BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Account created successfully! Now setup your Gym."), 
                          backgroundColor: Colors.green,
                        ),
                      );

                   // Yahan state se data lekar GymSetupScreen ko bhej rahe hain
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                    builder: (context) => GymSetupScreen(
                    preFilledName: state.name,
                    preFilledPhone: state.phone,
                   ),
                 ),
               );
             }
  if (state is AuthError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.message), 
        backgroundColor: Colors.redAccent,
      ),
    );
  }
},
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: state is AuthLoading ? null : () {
                        final name = nameController.text.trim();
                        final email = emailController.text.trim();
                        final rawPhone = phoneController.text.trim();
                        final password = passwordController.text.trim();
                        final confirmPassword = confirmPasswordController.text.trim();

                        if (name.isEmpty || email.isEmpty || rawPhone.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please fill all fields")),
                          );
                          return;
                        }

                        if (password != confirmPassword) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Passwords do not match!")),
                          );
                          return;
                        }

                        // Agar user ne direct copy kiya ya default country code rha toh fallback manual string banayega
                        final finalPhone = completePhoneNumber.isEmpty 
                            ? "$defaultCountryCode$rawPhone" 
                            : completePhoneNumber;

                        context.read<AuthBloc>().register(
                          name: name, 
                          email: email, 
                          phone: finalPhone, 
                          password: password,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F172A), 
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: state is AuthLoading 
                        ? const SizedBox(
                            height: 24, 
                            width: 24, 
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5)
                          ) 
                        : const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}