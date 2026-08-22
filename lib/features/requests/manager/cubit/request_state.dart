import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';

abstract class RequestsState {
  const RequestsState();
}

class RequestsInitial extends RequestsState {
  const RequestsInitial();
}

class RequestsLoading extends RequestsState {
  const RequestsLoading();
}

class RequestsSuccess extends RequestsState {
  final List<StudentRequest> pendingRequests;
  final List<StudentRequest> approvedRequests;
 
  final List<StudentRequest> rejectedRequests;
  final int totalCount;

  const RequestsSuccess({
    required this.pendingRequests,
    this.approvedRequests = const [],
    this.rejectedRequests = const [],
    this.totalCount = 0,
  });

  RequestsSuccess copyWith({
    List<StudentRequest>? pendingRequests,
    List<StudentRequest>? approvedRequests,
    List<StudentRequest>? rejectedRequests,
    int? totalCount,
  }) {
    return RequestsSuccess(
      pendingRequests: pendingRequests ?? this.pendingRequests,
      approvedRequests: approvedRequests ?? this.approvedRequests,
      rejectedRequests: rejectedRequests ?? this.rejectedRequests,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}

class RequestsFailure extends RequestsState {
  final Failure failure;
  const RequestsFailure(this.failure);
}