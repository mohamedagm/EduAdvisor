import 'package:edu_advisor/features/services/data/repo/course_registration_repo.dart';
import 'package:edu_advisor/features/services/manager/course_registration_cubit/course_registration_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseRegistrationCubit extends Cubit<CourseRegistrationState> {
  CourseRegistrationCubit({required CourseRegistrationRepo repo})
    : _repo = repo,
      super(const CourseRegistrationInitial());

  final CourseRegistrationRepo _repo;

  Future<void> getAvailableCourses() async {
    emit(const AvailableCoursesLoading());

    final result = await _repo.getAvailableCourses();

    if (isClosed) return;

    result.fold(
      (failure) => emit(AvailableCoursesFailure(failure)),
      (courses) => emit(AvailableCoursesLoaded(courses)),
    );
  }
}
