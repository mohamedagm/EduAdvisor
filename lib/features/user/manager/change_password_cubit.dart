import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/user/data/models/change_password_request_model.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ChangePasswordState {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial();
}

class ChangePasswordLoading extends ChangePasswordState {
  const ChangePasswordLoading();
}

class ChangePasswordSuccess extends ChangePasswordState {
  const ChangePasswordSuccess(this.message);

  final String message;
}

class ChangePasswordFailure extends ChangePasswordState {
  const ChangePasswordFailure(this.failure);

  final Failure failure;
}

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required UserRepo repo})
    : _repo = repo,
      super(const ChangePasswordInitial());

  final UserRepo _repo;

  Future<void> changePassword(ChangePasswordRequestModel request) async {
    emit(const ChangePasswordLoading());

    final result = await _repo.changePassword(request);

    if (isClosed) return;

    result.fold(
      (failure) => emit(ChangePasswordFailure(failure)),
      (response) => emit(ChangePasswordSuccess(response.message)),
    );
  }
}
