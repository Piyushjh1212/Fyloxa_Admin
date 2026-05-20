import '../../../../core/network/api_client.dart';
import '../modals/dashboard_stats_model.dart';

class DashboardRepository {
  final ApiClient apiClient;
  DashboardRepository(this.apiClient);

  Future<DashboardStats> getStats() async {
    final response = await apiClient.dio.get('dashboard/stats');
    return DashboardStats.fromJson(response.data);
  }
}