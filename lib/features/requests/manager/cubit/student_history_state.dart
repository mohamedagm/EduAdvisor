import 'package:edu_advisor/features/requests/models/student_history_model.dart';

abstract class StudentHistoryState {
  const StudentHistoryState();
}

class StudentHistoryInitial extends StudentHistoryState {
  const StudentHistoryInitial();
}

class StudentHistoryLoading extends StudentHistoryState {
  const StudentHistoryLoading();
}

class StudentHistorySuccess extends StudentHistoryState {
  final List<EnrollmentHistoryModel> history;

  const StudentHistorySuccess(this.history);
}

class StudentHistoryFailure extends StudentHistoryState {
  final String message;
  const StudentHistoryFailure(this.message);
}