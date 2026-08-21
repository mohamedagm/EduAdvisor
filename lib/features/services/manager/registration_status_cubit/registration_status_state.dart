import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/services/data/models/registration_request_model.dart';

abstract class RegistrationStatusState {
  const RegistrationStatusState();
}

class RegistrationStatusInitial extends RegistrationStatusState {
  const RegistrationStatusInitial();
}

class RegistrationStatusLoading extends RegistrationStatusState {
  const RegistrationStatusLoading();
}

class RegistrationStatusLoaded extends RegistrationStatusState {
  const RegistrationStatusLoaded(this.requests);

  final List<RegistrationRequestModel> requests;

  int get pendingCount => _countByStatus(1);
  int get approvedCount => _countByStatus(2);
  int get rejectedCount => _countByStatus(3);

  int _countByStatus(int status) {
    return requests.where((request) => request.status == status).length;
  }
}

class RegistrationStatusFailure extends RegistrationStatusState {
  const RegistrationStatusFailure(this.failure);

  final Failure failure;
}
