import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/advisor_nav/data/models/my_students_response_model.dart';

abstract class MyStudentsState {
  const MyStudentsState();
}

class MyStudentsInitial extends MyStudentsState {
  const MyStudentsInitial();
}

class MyStudentsLoading extends MyStudentsState {
  const MyStudentsLoading();
}

class MyStudentsSuccess extends MyStudentsState {
  final List<MyStudentModel> students;
  final int? totalCount;
  const MyStudentsSuccess(this.students, {this.totalCount = 0});
}

class MyStudentsFailure extends MyStudentsState {
  final Failure failure;
  const MyStudentsFailure(this.failure);
}