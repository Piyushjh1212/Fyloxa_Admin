import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart'; // Apne path ke hisab se adjust karein
import '../bloc/dashboard_bloc.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider yahan wrap kiya hai taaki data fetch ho sake
    return BlocProvider(
      create: (context) => sl<DashboardBloc>()..fetchStats(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Gym Dashboard")),
        body: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            // Loading state
            if (state is DashboardLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            // Error state
            if (state is DashboardError) {
              return Center(child: Text(state.message));
            }

            // Success state - Real Data show karenge
            if (state is DashboardLoaded) {
              final data = state.stats;
              return GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                children: [
                  _buildStatCard("Total Members", data.totalMembers.toString(), Colors.blue),
                  _buildStatCard("Active", data.activeSubscriptions.toString(), Colors.green),
                  _buildStatCard("Revenue", "₹${data.totalRevenue}", Colors.orange),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}