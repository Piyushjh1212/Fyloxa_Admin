import 'package:flutter/material.dart';

import './features/auth/presentation/sreens/login_page.dart';
import './core/storage/secure_auth_services_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Local storage initialize rahega taaki baki screens par dikkat na aaye
  await AuthService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Debug banner ko hide karne ke liye
      debugShowCheckedModeBanner: false,
      
      title: "Fyloxa",
      
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),

      // Ab bina kisi check ke direct Login Page call hoga
      home: const LoginPage(), 
    );
  }
}