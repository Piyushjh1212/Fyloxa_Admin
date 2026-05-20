import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screen/login_page.dart';
import '../../features/dashboard/presentation/screen/dashboard_screen.dart';
import '../../features/members/presentation/screens/members_list_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/navigation/main_navigation_screen.dart'; 
import '../../features/auth/presentation/screen/create_account_page.dart';
import '../../features/gym/presentation/screen/gym_setup_screen.dart';


final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    // 1. Login Route (Shell ke bahar - Full Screen)
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),

    // 2. Register Route (Shell ke bahar nikal diya taaki bottom nav bar crash na kare)
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterPage(),
    ),

    // 3. Gym Setup Route (Register ke baad yahan aayega)
    GoRoute(
      path: '/gym-setup',
      builder: (context, state) => GymSetupScreen(),
    ),

    // 4. Bottom Nav Shell (Sirf wahi screens jo bottom navigation bar share karengi)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainNavigationScreen(navigationShell: navigationShell);
      },
      branches: [
        // Branch 1: Dashboard
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard', 
              builder: (context, state) => const DashboardScreen(),
            ),
          ],
        ),
        // Branch 2: Members
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/members', 
              builder: (context, state) => const MembersListScreen(),
            ),
          ],
        ),
        // Branch 3: Profile
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile', 
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
  
  // Optional: Redirect logic 
  redirect: (context, state) {
    return null;
  },
);