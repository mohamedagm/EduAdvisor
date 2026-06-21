import 'package:edu_advisor/features/auth/data/repo/reset_password_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo _resetPasswordRepo;

  ResetPasswordCubit({required ResetPasswordRepo resetPasswordRepo})
    : _resetPasswordRepo = resetPasswordRepo,
      super(ResetPasswordInitial());

  Future<void> resetPassword({
    required String email,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoading());

    final result = await _resetPasswordRepo.resetPassword(
      email: email,
      token: token,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );

    result.fold(
      (failure) =>
          emit(ResetPasswordFailure(errorMessage: failure.apiResponse.message)),
      (apiResponse) => emit(ResetPasswordSuccess(message: apiResponse.message)),
    );
  }
}
