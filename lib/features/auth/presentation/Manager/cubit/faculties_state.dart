import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/auth/data/models/faculty_model.dart';

abstract class FacultiesState {
  const FacultiesState();
}

class FacultiesInitial extends FacultiesState {
  const FacultiesInitial();
}

class FacultiesLoading extends FacultiesState {
  const FacultiesLoading();
}

class FacultiesSuccess extends FacultiesState {
  final List<FacultyModel> faculties;
  const FacultiesSuccess(this.faculties);
}

class FacultiesFailure extends FacultiesState {
  final Failure failure;
  const FacultiesFailure(this.failure);
}
