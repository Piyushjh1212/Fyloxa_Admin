import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Saare features aur core files ke sahi imports
import 'core/network/api_client.dart';
import 'core/storage/secure_storage.dart';
import './features/auth/data/repositories/auth_repository_impl.dart';
import './features/auth/presentation/block/auth_bloc.dart';
import './features/dashboard/data/repositories/dashboard_repo.dart';
import './features/dashboard/presentation/bloc/dashboard_bloc.dart';
import './features/members/data/modals/repositories/member_repository_impl.dart';
import './features/members/presentation/block/members_bloc.dart';
import './features/profile/data/repositories/profile_repo.dart';
import './features/profile/presentation/block/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core / External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  
  sl.registerLazySingleton(() => SecureStorage());
  sl.registerLazySingleton(() => ApiClient());

  // Features - Auth
  sl.registerLazySingleton(() => AuthRepositoryImpl(sl()));
  sl.registerFactory(() => AuthBloc(sl()));

  // Features - Dashboard
  sl.registerLazySingleton(() => DashboardRepository(sl()));
  sl.registerFactory(() => DashboardBloc(sl()));

  // Features - Members
  sl.registerLazySingleton(() => MemberRepository(sl()));
  sl.registerFactory(() => MembersBloc(sl()));

  // Features - Profile
  sl.registerLazySingleton(() => ProfileRepository(sl()));
  sl.registerFactory(() => ProfileBloc(sl()));
}