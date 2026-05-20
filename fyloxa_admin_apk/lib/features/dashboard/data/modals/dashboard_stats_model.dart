class DashboardStats {
  final int totalMembers;
  final int activeSubscriptions;
  final double totalRevenue;

  DashboardStats({required this.totalMembers, required this.activeSubscriptions, required this.totalRevenue});

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalMembers: json['totalMembers'] ?? 0,
      activeSubscriptions: json['activeSubscriptions'] ?? 0,
      totalRevenue: (json['totalRevenue'] ?? 0).toDouble(),
    );
  }
}