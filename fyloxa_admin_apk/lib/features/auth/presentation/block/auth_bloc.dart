import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository_impl.dart';

// States
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {
  final String name;
  final String phone;
  AuthSuccess({required this.name, required this.phone});
}
class AuthError extends AuthState { 
  final String message; 
  AuthError(this.message); 
}

// Cubit/Bloc
class AuthBloc extends Cubit<AuthState> {
  final AuthRepositoryImpl repository;
  
  AuthBloc(this.repository) : super(AuthInitial());

// 1. Login Method
Future<void> login(String email, String password) async {
  emit(AuthLoading());
  try {
    await repository.login(email, password);
    // Yahan name aur phone chahiye honge. 
    // Agar login success par aapke pass user data nahi hai, 
    // toh LoginSuccess ke liye ek alag state bana lo ya name/phone empty bhej do.
    emit(AuthSuccess(name: "", phone: "")); 
  } catch (e) {
    emit(AuthError(e.toString()));
  }
}

  // 2. Register Method (Named Parameters ke sath ekdum sahi sync kiya)
  Future<void> register({
    required String name, 
    required String email, 
    required String phone, 
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await repository.register(
        name: name, 
        email: email, 
        phone: phone, 
        password: password,
      );
      emit(AuthSuccess(name: name, phone: phone));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}