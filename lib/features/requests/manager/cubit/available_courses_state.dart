import 'package:edu_advisor/features/requests/models/available_courses_model.dart';

abstract class AvailableCoursesState {
  const AvailableCoursesState();
}

class AvailableCoursesInitial extends AvailableCoursesState {
  const AvailableCoursesInitial();
}

class AvailableCoursesLoading extends AvailableCoursesState {
  const AvailableCoursesLoading();
}

class AvailableCoursesSuccess extends AvailableCoursesState {
  final StudentAvailableCoursesModel data;
  const AvailableCoursesSuccess(this.data);
}

class AvailableCoursesFailure extends AvailableCoursesState {
  final String message;
  const AvailableCoursesFailure(this.message);
}