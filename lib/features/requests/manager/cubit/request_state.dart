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
  // ⚠️ مفيش endpoint بترجع لستة الـ rejected من السيرفر، فدي بتتسجل
  // محليًا بس (في الذاكرة) أول ما تعملي reject لطلب من جوه التطبيق،
  // وبتتصفر مع أي Hot Restart أو إعادة فتح للتطبيق
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