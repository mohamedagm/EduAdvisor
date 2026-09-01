import 'package:edu_advisor/features/requests/data/repo/prerequisites_repository.dart';
import 'package:edu_advisor/features/requests/manager/cubit/prerequisites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PrerequisitesCubit extends Cubit<PrerequisitesState> {
  final PrerequisitesRepository _repository;

  PrerequisitesCubit(this._repository) : super(PrerequisitesInitialState());

  Future<void> fetchCoursePrerequisites(String semesterCourseId) async {
    emit(PrerequisitesLoadingState());

    final result = await _repository.getCoursePrerequisites(semesterCourseId);

    result.fold(
      (failure) => emit(PrerequisitesErrorState(failure.message)),
      (prerequisites) => emit(PrerequisitesSuccessState(prerequisites)),
    );
  }
}