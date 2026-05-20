import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../block/profile_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Profile")),
      body: Center(
        child: BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              // Logout hote hi Login page par redirect
              context.go('/login');
            }
          },
          child: ElevatedButton(
            onPressed: () => context.read<ProfileBloc>().logout(),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text("Logout", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}