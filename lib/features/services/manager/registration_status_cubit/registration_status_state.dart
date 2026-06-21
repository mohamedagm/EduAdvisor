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

  int get pendingCount => _countByStatus('pending');
  int get approvedCount => _countByStatus('approved');
  int get rejectedCount => _countByStatus('rejected');

  int _countByStatus(String status) {
    return requests
        .where(
          (request) =>
              request.status.trim().toLowerCase() == status.toLowerCase(),
        )
        .length;
  }
}

class RegistrationStatusFailure extends RegistrationStatusState {
  const RegistrationStatusFailure(this.failure);

  final Failure failure;
}
