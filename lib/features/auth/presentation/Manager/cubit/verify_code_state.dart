import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';

abstract class VerifyCodeState {
  const VerifyCodeState();
}

class VerifyCodeInitial extends VerifyCodeState {
  const VerifyCodeInitial();
}

// Verify OTP
class VerifyOtpLoading extends VerifyCodeState {
  const VerifyOtpLoading();
}

class VerifyOtpSuccess extends VerifyCodeState {
  final ApiResponseModel response;
  const VerifyOtpSuccess(this.response);
}

class VerifyOtpFailure extends VerifyCodeState {
  final Failure failure;
  const VerifyOtpFailure(this.failure);
}

// Resend OTP
class ResendOtpLoading extends VerifyCodeState {
  const ResendOtpLoading();
}

class ResendOtpSuccess extends VerifyCodeState {
  final ApiResponseModel response;
  const ResendOtpSuccess(this.response);
}

class ResendOtpFailure extends VerifyCodeState {
  final Failure failure;
  const ResendOtpFailure(this.failure);
}