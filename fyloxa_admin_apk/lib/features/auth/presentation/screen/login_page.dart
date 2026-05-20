import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; 
import '../../../../core/widgets/custom_text_field.dart';
import '../block/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Ultra clean Slate background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Brand Header Section
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            )
                          ],
                        ),
                        child: const Icon(
                          Icons.blur_on_rounded, 
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Fyloxa Admin",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A), 
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Welcome back! Please enter your details.",
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                // Form Section
                const Text(
                  "Email Address",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: emailController, 
                  hintText: 'name@company.com',
                ),
                const SizedBox(height: 18),
                
                const Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF334155),
                  ),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: passwordController, 
                  hintText: '••••••••', 
                  isPassword: true,
                ),
                const SizedBox(height: 14),

                // Forgot Password Placeholder
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                
                // Main Sign In Button with BLoC
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    
                    return SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          if (emailController.text.trim().isEmpty || 
                              passwordController.text.trim().isEmpty) {
                            return;
                          }
                          context.read<AuthBloc>().login(
                            emailController.text.trim(), 
                            passwordController.text.trim(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // "OR" Divider Zone
                Row(
                  children: const [
                    Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Color(0xFFE2E8F0), thickness: 1)),
                  ],
                ),
                const SizedBox(height: 24),

                // Social Logins (Google & Apple)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.google, size: 18, color: Colors.redAccent),
                        label: const Text("Google"),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48), // Height fix kiya yahan
                          foregroundColor: const Color(0xFF334155),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const FaIcon(FontAwesomeIcons.apple, size: 20, color: Colors.black),
                        label: const Text("Apple"),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48), // Height fix kiya yahan
                          foregroundColor: const Color(0xFF334155),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Footer Section: Create Account Link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          GoRouter.of(context).push('/register');
                        },
                        child: Text(
                          "Create an account",
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
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
      ),
    );
  }
}