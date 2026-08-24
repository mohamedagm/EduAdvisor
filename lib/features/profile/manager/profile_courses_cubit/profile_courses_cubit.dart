import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/profile/data/models/student_enrollment_model.dart';
import 'package:edu_advisor/features/profile/data/repo/profile_courses_repo.dart';
import 'package:edu_advisor/features/profile/manager/profile_courses_cubit/profile_courses_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCoursesCubit extends Cubit<ProfileCoursesState> {
  ProfileCoursesCubit({required ProfileCoursesRepo profileCoursesRepo})
    : _profileCoursesRepo = profileCoursesRepo,
      super(const ProfileCoursesInitial());

  final ProfileCoursesRepo _profileCoursesRepo;

  Future<void> getMyCourses() async {
    emit(const ProfileCoursesLoading());

    final results = await Future.wait([
      _profileCoursesRepo.getEnrollments(),
      _profileCoursesRepo.getEnrollments(isPassed: true),
      _profileCoursesRepo.getEnrollments(isPassed: false),
    ]);

    if (isClosed) return;

    String? errorMessage;
    final lists = results.map((result) {
      return result.fold(
        (failure) {
          errorMessage ??= failure.message;
          return <StudentEnrollmentModel>[];
        },
        (courses) => courses,
      );
    }).toList();

    if (errorMessage != null) {
      emit(
        ProfileCoursesFailure(
          ServerFailure(ApiResponseModel.message(errorMessage!)),
        ),
      );
      return;
    }

    emit(
      ProfileCoursesLoaded(
        all: lists[0],
        passed: lists[1],
        failed: lists[2],
      ),
    );
  }
}
