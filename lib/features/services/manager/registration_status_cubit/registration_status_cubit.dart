import 'package:edu_advisor/features/services/data/repo/course_registration_repo.dart';
import 'package:edu_advisor/features/services/manager/registration_status_cubit/registration_status_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationStatusCubit extends Cubit<RegistrationStatusState> {
  RegistrationStatusCubit({required CourseRegistrationRepo repo})
    : _repo = repo,
      super(const RegistrationStatusInitial());

  final CourseRegistrationRepo _repo;

  Future<void> getRegistrationRequests() async {
    emit(const RegistrationStatusLoading());

    final result = await _repo.getRegistrationRequests();

    if (isClosed) return;

    result.fold(
      (failure) => emit(RegistrationStatusFailure(failure)),
      (requests) => emit(RegistrationStatusLoaded(requests)),
    );
  }
}
