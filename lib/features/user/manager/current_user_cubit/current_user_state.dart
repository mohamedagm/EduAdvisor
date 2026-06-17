import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';

abstract class CurrentUserState {
  const CurrentUserState();
}

class CurrentUserInitial extends CurrentUserState {
  const CurrentUserInitial();
}

class CurrentUserLoading extends CurrentUserState {
  const CurrentUserLoading();
}

class CurrentUserLoaded extends CurrentUserState {
  const CurrentUserLoaded(this.user);

  final CurrentUserModel user;
}

class CurrentUserFailure extends CurrentUserState {
  const CurrentUserFailure(this.failure);

  final Failure failure;
}
