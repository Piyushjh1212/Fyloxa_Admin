abstract class GymState {}

class GymInitial extends GymState {}
class GymSetupLoading extends GymState {}
class GymSetupSuccess extends GymState {}
class GymSetupFailure extends GymState {
  final String error;
  GymSetupFailure(this.error);
}