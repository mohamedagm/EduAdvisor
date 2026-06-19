import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/auth/data/models/department_model.dart';

abstract class DepartmentsState {
  const DepartmentsState();
}

class DepartmentsInitial extends DepartmentsState {
  const DepartmentsInitial();
}

class DepartmentsLoading extends DepartmentsState {
  const DepartmentsLoading();
}

class DepartmentsSuccess extends DepartmentsState {
  final List<DepartmentModel> departments;
  const DepartmentsSuccess(this.departments);
}

class DepartmentsFailure extends DepartmentsState {
  final Failure failure;
  const DepartmentsFailure(this.failure);
}