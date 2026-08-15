// forgot_password_cubit.dart
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/forgot_password_state.dart';
import 'package:edu_advisor/features/auth/data/repo/forgot_password_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo _repo;

  ForgotPasswordCubit({required ForgotPasswordRepo repo})
      : _repo = repo,
        super(ForgotPasswordInitial());

  Future<void> sendOtp({required String email}) async {
    emit(ForgotPasswordLoading());
    final result = await _repo.sendOtp(email: email);
    result.fold(
      (failure) => emit(ForgotPasswordFailure(failure.message)),
      (response) => emit(ForgotPasswordSuccess(response)),
    );
  }
}