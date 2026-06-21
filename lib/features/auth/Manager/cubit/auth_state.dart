import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/auth/data/models/login_response_model.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class LoginLoading extends AuthState {
  const LoginLoading();
}

class LoginSuccess extends AuthState {
  const LoginSuccess(this.response);

  final LoginResponseModel response;
}

class LoginFailure extends AuthState {
  const LoginFailure(this.failure);

  final Failure failure;
}

class RegisterStudentLoading extends AuthState {
  const RegisterStudentLoading();
}

class RegisterStudentSuccess extends AuthState {
  const RegisterStudentSuccess(this.response);

  final ApiResponseModel response;
}

class RegisterStudentFailure extends AuthState {
  const RegisterStudentFailure(this.failure);

  final Failure failure;
}

class RegisterAdvisorLoading extends AuthState {
  const RegisterAdvisorLoading();
}

class RegisterAdvisorSuccess extends AuthState {
  const RegisterAdvisorSuccess(this.response);

  final ApiResponseModel response;
}

class RegisterAdvisorFailure extends AuthState {
  const RegisterAdvisorFailure(this.failure);

  final Failure failure;
}

class LogoutLoading extends AuthState {
  const LogoutLoading();
}

class LogoutSuccess extends AuthState {
  const LogoutSuccess(this.response);

  final ApiResponseModel response;
}

class LogoutFailure extends AuthState {
  const LogoutFailure(this.failure);

  final Failure failure;
}
