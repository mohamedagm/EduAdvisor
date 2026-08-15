import 'package:edu_advisor/features/auth/data/models/login_request_model.dart';
import 'package:edu_advisor/features/auth/data/models/register_advisor_request_model.dart';
import 'package:edu_advisor/features/auth/data/models/register_student_request_model.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(const AuthInitial());

  final AuthRepo _authRepo;

  Future<void> login(
    LoginRequestModel request, {
    required String expectedRole,
  }) async {
    if (state is LoginLoading) return;

    emit(const LoginLoading());

    final result = await _authRepo.login(request, expectedRole: expectedRole);

    result.fold(
      (failure) => emit(LoginFailure(failure)),
      (response) => emit(LoginSuccess(response)),
    );
  }

  Future<void> registerStudent(RegisterStudentRequestModel request) async {
    if (state is RegisterStudentLoading) return;

    emit(const RegisterStudentLoading());

    final result = await _authRepo.registerStudent(request);

    result.fold(
      (failure) => emit(RegisterStudentFailure(failure)),
      (response) => emit(RegisterStudentSuccess(response)),
    );
  }

  Future<void> registerAdvisor(RegisterAdvisorRequestModel request) async {
    if (state is RegisterAdvisorLoading) return;

    emit(const RegisterAdvisorLoading());

    final result = await _authRepo.registerAdvisor(request);

    result.fold(
      (failure) => emit(RegisterAdvisorFailure(failure)),
      (response) => emit(RegisterAdvisorSuccess(response)),
    );
  }

  Future<void> logout() async {
    if (state is LogoutLoading) return;

    emit(const LogoutLoading());

    final result = await _authRepo.logout();

    result.fold(
      (failure) => emit(LogoutFailure(failure)),
      (response) => emit(LogoutSuccess(response)),
    );
  }
}
