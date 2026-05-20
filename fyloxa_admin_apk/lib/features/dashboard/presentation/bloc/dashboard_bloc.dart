import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/modals/dashboard_stats_model.dart';
import '../../data/repositories/dashboard_repo.dart';

// States
abstract class DashboardState {}
class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {
  final DashboardStats stats;
  DashboardLoaded(this.stats);
}
class DashboardError extends DashboardState {
  final String message;
  DashboardError(this.message);
}

// Bloc
class DashboardBloc extends Cubit<DashboardState> {
  final DashboardRepository repository;
  DashboardBloc(this.repository) : super(DashboardInitial());

  Future<void> fetchStats() async {
    emit(DashboardLoading());
    try {
      final stats = await repository.getStats();
      emit(DashboardLoaded(stats));
    } catch (e) {
      emit(DashboardError("Failed to load dashboard data"));
    }
  }
}