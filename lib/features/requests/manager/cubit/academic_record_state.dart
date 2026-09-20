
import 'package:edu_advisor/features/requests/models/student_academic_record.dart';

abstract class AcademicRecordState {}

class AcademicRecordInitialState extends AcademicRecordState {}

class AcademicRecordLoadingState extends AcademicRecordState {}

class AcademicRecordSuccessState extends AcademicRecordState {
  final StudentAcademicRecord record;

  AcademicRecordSuccessState(this.record);
}

class AcademicRecordErrorState extends AcademicRecordState {
  final String message;

  AcademicRecordErrorState(this.message);
}