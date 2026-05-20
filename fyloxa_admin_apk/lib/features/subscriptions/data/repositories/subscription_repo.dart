class SubscriptionRepository {
  final ApiClient apiClient;
  SubscriptionRepository(this.apiClient);

  Future<List<Subscription>> getSubscriptionHistory() async {
    final response = await apiClient.dio.get('subscriptions/history');
    // Map response to list of Subscription objects...
    return []; 
  }
}