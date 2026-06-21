import 'package:edu_advisor/features/advisor_nav/data/repo/advisor_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_students_state.dart';

class MyStudentsCubit extends Cubit<MyStudentsState> {
  MyStudentsCubit({required AdvisorRepo advisorRepo})
    : _advisorRepo = advisorRepo,
      super(const MyStudentsInitial());

  final AdvisorRepo _advisorRepo;

  Future<void> fetchMyStudents({String? searchText}) async {
    if (state is MyStudentsLoading) return;

    emit(const MyStudentsLoading());

    final result = await _advisorRepo.getMyStudents(
      search: searchText,
      pageNumber: 1,
      pageSize: 20,
    );

    result.fold(
      (failure) => emit(MyStudentsFailure(failure)),
      (data) => emit(
        MyStudentsSuccess(data.students, totalCount: data.totalCount),
      ),
    );
  }
}