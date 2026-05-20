import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/login_page.dart';
import 'injection_container.dart';

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(), // DI se Bloc inject kiya
      child: MaterialApp(
        routerConfig: appRouter, // Yahan apna router pass karo
        // home: LoginPage(),
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}