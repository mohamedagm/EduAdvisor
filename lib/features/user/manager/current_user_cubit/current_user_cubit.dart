import 'dart:io';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserCubit extends Cubit<CurrentUserState> {
  CurrentUserCubit({required UserRepo userRepo})
      : _userRepo = userRepo,
        super(const CurrentUserInitial());

  final UserRepo _userRepo;

  Future<void> getMe({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final cachedUser = await _userRepo.getCachedMe();

      if (cachedUser != null) {
        emit(CurrentUserLoaded(cachedUser));
        return;
      }
    }

    emit(const CurrentUserLoading());

    final result = await _userRepo.getMe();

    result.fold(
      (failure) => emit(CurrentUserFailure(failure)),
      (user) => emit(CurrentUserLoaded(user)),
    );
  }

  Future<void> updateProfilePhoto(File imageFile) async {
    final result = await _userRepo.changeProfilePhoto(imageFile);

    result.fold(
      (failure) {
       
      },
      (_) async {
      
        await getMe(forceRefresh: true);
      },
    );
  }
}