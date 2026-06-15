import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/failures.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
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
