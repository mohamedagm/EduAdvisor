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

    final result = await _profileCoursesRepo.getMyCourses();

    if (isClosed) return;

    result.fold(
      (failure) => emit(ProfileCoursesFailure(failure)),
      (courses) => emit(ProfileCoursesLoaded(courses)),
    );
  }
}
