import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/profile_repo.dart';

abstract class ProfileState {}
class ProfileInitial extends ProfileState {}
class LogoutLoading extends ProfileState {}
class LogoutSuccess extends ProfileState {}

class ProfileBloc extends Cubit<ProfileState> {
  final ProfileRepository repository;
  ProfileBloc(this.repository) : super(ProfileInitial());

  Future<void> logout() async {
    emit(LogoutLoading());
    await repository.logout();
    emit(LogoutSuccess());
  }
}