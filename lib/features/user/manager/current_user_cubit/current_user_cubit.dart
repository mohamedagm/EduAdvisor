import 'package:edu_advisor/features/user/data/repo/user_repo.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit({required UserRepo userRepo})
    : _userRepo = userRepo,
      super(const CurrentUserInitial());

  final UserRepo _userRepo;

  Future<void> getMe() async {
    emit(const CurrentUserLoading());

    final result = await _userRepo.getMe();

    result.fold(
      (failure) => emit(CurrentUserFailure(failure)),
      (user) => emit(CurrentUserLoaded(user)),
    );
  }
}
