import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/requests/data/repo/advisor_request_repo.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit({required AdvisorRepo advisorRepo})
      : _advisorRepo = advisorRepo,
        super(const RequestsInitial());

  final AdvisorRepo _advisorRepo;

  Future<void> fetchAllRequests() async {
    if (state is RequestsLoading) return;

    emit(const RequestsLoading());

    final result = await _advisorRepo.getAllRequests(
      pageNumber: 1,
      pageSize: 50,
    );

    result.fold(
      (failure) => emit(RequestsFailure(failure)),
      (data) {
        final pending = data.requests
            .where((r) => r.status.toLowerCase() == 'pending')
            .toList();
        final approved = data.requests
            .where((r) => r.status.toLowerCase() == 'approved')
            .toList();
        final rejected = data.requests
            .where((r) => r.status.toLowerCase() == 'rejected')
            .toList();

        emit(RequestsSuccess(
          pendingRequests: pending,
          approvedRequests: approved,
          rejectedRequests: rejected,
          totalCount: data.totalCount,
        ));
      },
    );
  }

  Future<void> fetchPendingRequests() => fetchAllRequests();
  Future<void> fetchApprovedRequests() => fetchAllRequests();
  Future<void> fetchRejectedRequests() => fetchAllRequests();

  Future<Failure?> approveRequest(String id) async {
    final result = await _advisorRepo.approveRequest(id);
    final failure = result.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(RequestsFailure(failure));
      return failure;
    }

    if (state is RequestsSuccess) {
      final currentState = state as RequestsSuccess;
      final requestIndex =
          currentState.pendingRequests.indexWhere((r) => r.id == id);
      if (requestIndex != -1) {
        final approvedRequest = currentState.pendingRequests[requestIndex]
            .copyWith(status: 'Approved');
        final pendingRequests =
            List<StudentRequest>.of(currentState.pendingRequests)
              ..removeAt(requestIndex);
        final approvedRequests =
            List<StudentRequest>.of(currentState.approvedRequests)
              ..add(approvedRequest);

        emit(currentState.copyWith(
          pendingRequests: pendingRequests,
          approvedRequests: approvedRequests,
        ));
        return null;
      }
    }

    await fetchAllRequests();
    return null;
  }

  Future<Failure?> rejectRequest(String id,
      {String reason = "Rejected by Advisor"}) async {
    final result = await _advisorRepo.rejectRequest(id, reason: reason);
    final failure = result.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(RequestsFailure(failure));
      return failure;
    }

    if (state is RequestsSuccess) {
      final currentState = state as RequestsSuccess;
      final requestIndex =
          currentState.pendingRequests.indexWhere((r) => r.id == id);
      if (requestIndex != -1) {
        final rejectedRequest = currentState.pendingRequests[requestIndex]
            .copyWith(status: 'Rejected');
        final pendingRequests =
            List<StudentRequest>.of(currentState.pendingRequests)
              ..removeAt(requestIndex);
        final rejectedRequests =
            List<StudentRequest>.of(currentState.rejectedRequests)
              ..add(rejectedRequest);

        emit(currentState.copyWith(
          pendingRequests: pendingRequests,
          rejectedRequests: rejectedRequests,
        ));
        return null;
      }
    }

    await fetchAllRequests();
    return null;
  }
}