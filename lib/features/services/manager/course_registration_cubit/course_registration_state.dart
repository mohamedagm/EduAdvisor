import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/features/services/data/models/available_course_model.dart';

abstract class CourseRegistrationState {
  const CourseRegistrationState();
}

class CourseRegistrationInitial extends CourseRegistrationState {
  const CourseRegistrationInitial();
}

class AvailableCoursesLoading extends CourseRegistrationState {
  const AvailableCoursesLoading();
}

class AvailableCoursesLoaded extends CourseRegistrationState {
  const AvailableCoursesLoaded(this.courses);

  final List<AvailableCourseModel> courses;
}

class AvailableCoursesFailure extends CourseRegistrationState {
  const AvailableCoursesFailure(this.failure);

  final Failure failure;
}

class SubmitRegistrationLoading extends CourseRegistrationState {
  const SubmitRegistrationLoading();
}

class SubmitRegistrationSuccess extends CourseRegistrationState {
  const SubmitRegistrationSuccess(this.response);

  final ApiResponseModel response;
}

class SubmitRegistrationFailure extends CourseRegistrationState {
  const SubmitRegistrationFailure(this.failure);

  final Failure failure;
}
