import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/advisor_nav/data/repo/advisor_repo.dart';
import 'package:edu_advisor/features/analytics/data/models/advisor_dashboard_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  const DashboardLoaded(this.dashboard);

  final AdvisorDashboardModel dashboard;
}

class DashboardFailure extends DashboardState {
  const DashboardFailure(this.failure);

  final Failure failure;
}

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit({required AdvisorRepo repo})
    : _repo = repo,
      super(const DashboardInitial());

  final AdvisorRepo _repo;

  Future<void> fetchDashboard() async {
    emit(const DashboardLoading());

    final result = await _repo.getDashboard();

    if (isClosed) return;

    result.fold(
      (failure) => emit(DashboardFailure(failure)),
      (dashboard) => emit(DashboardLoaded(dashboard)),
    );
  }
}
