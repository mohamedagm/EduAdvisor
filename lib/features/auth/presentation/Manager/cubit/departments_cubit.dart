import 'package:edu_advisor/features/auth/presentation/Manager/cubit/departments_state.dart';
import 'package:edu_advisor/features/auth/data/repo/departments_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentsCubit extends Cubit<DepartmentsState> {
  final DepartmentsRepo _departmentsRepo;

  DepartmentsCubit({required DepartmentsRepo departmentsRepo})
      : _departmentsRepo = departmentsRepo,
        super(const DepartmentsInitial());

  Future<void> fetchDepartments() async {
    
    if (state is DepartmentsLoading) return;

    emit(const DepartmentsLoading());

    final result = await _departmentsRepo.getDepartments();

    result.fold(
      (failure) => emit(DepartmentsFailure(failure)),
      (departments) => emit(DepartmentsSuccess(departments)),
    );
  }
}