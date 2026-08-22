import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/requests/data/repo/advisor_request_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit({required AdvisorRequestRepo advisorRepo})
      : _advisorRepo = advisorRepo,
        super(const RequestsInitial());

  final AdvisorRequestRepo _advisorRepo;

  // جلب البيانات بالاعتماد على Status الأرقام (0=Pending, 1=Approved, 2=Rejected)
  Future<void> fetchRequests({
    int? status = 1,
    int page = 1,
  }) async {
    emit(const RequestsLoading());

    final result = await _advisorRepo.getRegistrations(
      status: status,
      pageNumber: page,
      pageSize: 50,
    );

    result.fold(
      (failure) => emit(RequestsFailure(failure)),
      (data) {
        emit(
          RequestsSuccess(
            pendingRequests: status == 1 ? data.requests : [],
            approvedRequests: status == 2 ? data.requests : [],
            rejectedRequests: status == 3 ? data.requests : [],
            totalCount: data.totalCount,
          ),
        );
      },
    );
  }

  Future<void> fetchPendingRequests() => fetchRequests(status: 1);

  Future<void> fetchApprovedRequests() => fetchRequests(status: 2);

  Future<void> fetchRejectedRequests() => fetchRequests(status: 3);

  Future<Failure?> approveRequest(String id) async {
    final result = await _advisorRepo.approveRequest(id);
    final failure = result.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(RequestsFailure(failure));
      return failure;
    }

    await fetchPendingRequests();
    return null;
  }

  Future<Failure?> rejectRequest(
    String id, {
    String reason = "Rejected by Advisor",
  }) async {
    final result = await _advisorRepo.rejectRequest(id, reason: reason);
    final failure = result.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(RequestsFailure(failure));
      return failure;
    }

    await fetchPendingRequests();
    return null;
  }
}