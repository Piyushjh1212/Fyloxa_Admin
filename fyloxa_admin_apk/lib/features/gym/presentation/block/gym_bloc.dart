import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/gym_repository_impl.dart';
import '../../data/repositories/gym_repository_impl.dart';
import './gym_event.dart';
import './gym_state.dart';

class GymBloc extends Bloc<GymEvent, GymState> {
  final GymRepositoryImpl gymRepository;

  GymBloc(this.gymRepository) : super(GymInitial()) {
    on<SubmitGymSetup>((event, emit) async {
      emit(GymSetupLoading());
      try {
        await gymRepository.setupGym(event.request);
        emit(GymSetupSuccess());
      } catch (e) {
        emit(GymSetupFailure(e.toString()));
      }
    });
  }
}