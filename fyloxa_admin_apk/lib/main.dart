import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // 1. Flutter Bloc import kiya
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './core/router/app_router.dart';
import './injection_container.dart' as di;

// Apne Blocs ko import karein (Sahi path check kar lein agar alag ho)

import './features/auth/presentation/block/auth_bloc.dart';
import './features/members/presentation/block/members_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Env variables initialize karein
  await dotenv.load(fileName: ".env");

  // Dependency Injection initialize karein
  await di.init(); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. MaterialApp.router ko MultiBlocProvider se wrap kiya
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => di.sl<AuthBloc>(),
        ),
        BlocProvider<MembersBloc>(
          create: (context) => di.sl<MembersBloc>(),
        ),
        // Agar Dashboard ya Profile ke blocs hain toh unhe bhi yahan add kar sakte hain
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Fyloxa",
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        routerConfig: appRouter, 
      ),
    );
  }
}