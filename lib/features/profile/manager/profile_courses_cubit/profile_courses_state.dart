import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/profile/data/models/student_course_model.dart';
import 'package:edu_advisor/features/profile/data/models/student_courses_model.dart';

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
  const ProfileCoursesLoaded(this.courses);

  final StudentCoursesModel courses;

  List<StudentCourseModel> coursesForTab(int index) {
    switch (index) {
      case 0:
        return courses.completed;
      case 1:
        return courses.inProgress;
      case 2:
        return courses.remaining;
      default:
        return courses.remaining;
    }
  }
}

class ProfileCoursesFailure extends ProfileCoursesState {
  const ProfileCoursesFailure(this.failure);

  final Failure failure;
}
