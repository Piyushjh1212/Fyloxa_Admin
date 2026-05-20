import '../../../../core/network/api_client.dart';
import '../../../../core/network/error_handler.dart';
import '../models/gym_model.dart';

class GymRepositoryImpl {
  final ApiClient apiClient;

  GymRepositoryImpl(this.apiClient);

  Future<void> setupGym(GymSetupRequest request) async {
    try {
      // Backend setup API endpoint 'gym/setup' ya jo aapka ho
      await apiClient.dio.post(
        'gym/setup',
        data: request.toJson(),
      );
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}