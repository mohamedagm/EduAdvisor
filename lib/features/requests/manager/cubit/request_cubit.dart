import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/requests/data/repo/advisor_request_repo.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'request_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit({required AdvisorRequestRepo advisorRepo})
      : _advisorRepo = advisorRepo,
        super(const RequestsInitial());

  final AdvisorRequestRepo _advisorRepo;

  /// ميثود رئيسية موحدة لجلب البيانات من الـ API المناسب بناءً على الـ status والـ search
  Future<void> fetchRequests({String? status, String? search, int page = 1}) async {
    emit(const RequestsLoading());

    // لو الحالة تحت المراجعة نطلب من الـ API القديم، ولو مقبولة أو مرفوضة نطلب من الـ API الجديد للـ Processed
    final result = (status == 'Pending' || status == null)
        ? await _advisorRepo.getAllRequests(pageNumber: page, pageSize: 50)
        : await _advisorRepo.getProcessedRequests(
            status: status,
            search: search,
            pageNumber: page,
            pageSize: 50,
          );

    result.fold(
      (failure) => emit(RequestsFailure(failure)),
      (data) {
        // نضع البيانات في الـ List المقابلة للحالة المطلوبة للحفاظ على استقرار الـ UI القديم
        emit(
          RequestsSuccess(
            pendingRequests: (status == 'Pending' || status == null) ? data.requests : [],
            approvedRequests: status == 'Approved' ? data.requests : [],
            rejectedRequests: status == 'Rejected' ? data.requests : [],
            totalCount: data.totalCount,
          ),
        );
      },
    );
  }

  // استدعاءات مخصصة وسهلة لكل تابة أو شاشة في الـ UI
  Future<void> fetchPendingRequests() => fetchRequests(status: 'Pending');
  
  Future<void> fetchApprovedRequests({String? search}) => 
      fetchRequests(status: 'Approved', search: search);
      
  Future<void> fetchRejectedRequests({String? search}) => 
      fetchRequests(status: 'Rejected', search: search);

  /// ميثود لتنفيذ عملية البحث (Search) من جهة السيرفر
  Future<void> searchRequests(String query, {required String currentStatus}) async {
    if (query.trim().isEmpty) {
      await fetchRequests(status: currentStatus);
    } else {
      await fetchRequests(status: currentStatus, search: query);
    }
  }

  /// ميثود الموافقة على طلب
  Future<Failure?> approveRequest(String id) async {
    final result = await _advisorRepo.approveRequest(id);
    final failure = result.fold((f) => f, (_) => null);

    if (failure != null) {
      emit(RequestsFailure(failure));
      return failure;
    }

    // عمل تحديث تلقائي للقائمة بعد الموافقة الناجحة لنقل الطلب
    await fetchRequests(status: 'Pending');
    return null;
  }

  /// ميثود رفض طلب مع تقديم سبب
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

    // عمل تحديث تلقائي للقائمة بعد الرفض
    await fetchRequests(status: 'Pending');
    return null;
  }
}