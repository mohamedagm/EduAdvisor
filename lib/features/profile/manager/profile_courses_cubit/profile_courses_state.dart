import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/profile/data/models/student_enrollment_model.dart';

abstract class ProfileCoursesState {
  const ProfileCoursesState();
}

class ProfileCoursesInitial extends ProfileCoursesState {
  const ProfileCoursesInitial();
}

class ProfileCoursesLoading extends ProfileCoursesState {
  const ProfileCoursesLoading();
}

class ProfileCoursesLoaded extends ProfileCoursesState {
  const ProfileCoursesLoaded({
    required this.all,
    required this.passed,
    required this.failed,
  });

  final List<StudentEnrollmentModel> all;
  final List<StudentEnrollmentModel> passed;
  final List<StudentEnrollmentModel> failed;

  List<StudentEnrollmentModel> coursesForTab(int index) {
    switch (index) {
      case 1:
        return passed;
      case 2:
        return failed;
      default:
        return all;
    }
  }
}

class ProfileCoursesFailure extends ProfileCoursesState {
  const ProfileCoursesFailure(this.failure);

  final Failure failure;
}
