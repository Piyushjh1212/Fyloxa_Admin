import '../../data/models/gym_model.dart';

abstract class GymEvent {}

class SubmitGymSetup extends GymEvent {
  final GymSetupRequest request;
  SubmitGymSetup(this.request);
}