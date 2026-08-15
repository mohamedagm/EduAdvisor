import 'package:flutter_bloc/flutter_bloc.dart';
import 'verify_code_state.dart';
import 'package:edu_advisor/features/auth/data/repo/verify_code_repo.dart';

class VerifyCodeCubit extends Cubit<VerifyCodeState> {
  VerifyCodeCubit({required VerifyCodeRepo verifyCodeRepo})
      : _verifyCodeRepo = verifyCodeRepo,
        super(const VerifyCodeInitial());

  final VerifyCodeRepo _verifyCodeRepo;

  Future<void> verifyOtp({
  required String email,
  required String code,
  bool isFromForgotPassword = false, 
}) async {
  if (state is VerifyOtpLoading) return;
  emit(const VerifyOtpLoading());

  final result = isFromForgotPassword
      ? await _verifyCodeRepo.verifyResetOtp(email: email, code: code)
      : await _verifyCodeRepo.verifyOtp(email: email, code: code);

  result.fold(
    (failure) => emit(VerifyOtpFailure(failure)),
    (response) => emit(VerifyOtpSuccess(response)),
  );
}

  Future<void> resendOtp({required String email}) async {
    if (state is ResendOtpLoading) return;

    emit(const ResendOtpLoading());

    final result = await _verifyCodeRepo.resendOtp(email: email);

    result.fold(
      (failure) => emit(ResendOtpFailure(failure)),
      (response) => emit(ResendOtpSuccess(response)),
    );
  }
}