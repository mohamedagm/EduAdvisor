
import 'package:edu_advisor/features/requests/data/repo/academic_record_repo.dart';
import 'package:edu_advisor/features/requests/manager/cubit/academic_record_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcademicRecordCubit extends Cubit<AcademicRecordState> {
  final AcademicRecordRepository _repository;

  AcademicRecordCubit(this._repository) : super(AcademicRecordInitialState());

  Future<void> fetchStudentAcademicRecord(String studentId) async {
    if (isClosed) return;
    emit(AcademicRecordLoadingState());

    final result = await _repository.getStudentAcademicRecord(studentId);

    if (isClosed) return;
    result.fold(
      (failure) => emit(AcademicRecordErrorState(failure.message)),
      (record) => emit(AcademicRecordSuccessState(record)),
    );
  }
}