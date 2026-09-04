import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/features/requests/data/repo/student_history_repo.dart';
import 'package:edu_advisor/features/requests/manager/cubit/student_history_state.dart';

class StudentHistoryCubit extends Cubit<StudentHistoryState> {
  final StudentHistoryRepo _repo;

  StudentHistoryCubit(this._repo) : super(const StudentHistoryInitial());

  Future<void> fetchStudentHistory(String studentId) async {
    emit(const StudentHistoryLoading());

    final result = await _repo.getStudentHistory(studentId);

    result.fold(
      (failure) => emit(StudentHistoryFailure(failure.apiResponse.message)),
      (history) => emit(StudentHistorySuccess(history)),
    );
  }
}