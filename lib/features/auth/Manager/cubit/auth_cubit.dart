import 'package:edu_advisor/features/auth/data/models/register_advisor_request_model.dart';
import 'package:edu_advisor/features/auth/data/models/register_student_request_model.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(const AuthInitial());

  final AuthRepo _authRepo;

  Future<void> registerStudent(RegisterStudentRequestModel request) async {
    emit(const RegisterStudentLoading());

    final result = await _authRepo.registerStudent(request);

    result.fold(
      (failure) => emit(RegisterStudentFailure(failure)),
      (response) => emit(RegisterStudentSuccess(response)),
    );
  }

  Future<void> registerAdvisor(RegisterAdvisorRequestModel request) async {
    emit(const RegisterAdvisorLoading());

    final result = await _authRepo.registerAdvisor(request);

    result.fold(
      (failure) => emit(RegisterAdvisorFailure(failure)),
      (response) => emit(RegisterAdvisorSuccess(response)),
    );
  }
}
