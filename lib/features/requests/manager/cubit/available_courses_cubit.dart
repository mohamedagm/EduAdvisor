import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/features/requests/data/repo/available_courses_repo.dart';
import 'package:edu_advisor/features/requests/manager/cubit/available_courses_state.dart';

class AvailableCoursesCubit extends Cubit<AvailableCoursesState> {
  final AvailableCoursesRepo _repo;

  AvailableCoursesCubit(this._repo) : super(const AvailableCoursesInitial());

  Future<void> fetchAvailableCourses(String studentId) async {
    if (isClosed) return;
    emit(const AvailableCoursesLoading());

    final result = await _repo.getAvailableCourses(studentId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(AvailableCoursesFailure(failure.apiResponse.message)),
      (data) => emit(AvailableCoursesSuccess(data)),
    );
  }
}