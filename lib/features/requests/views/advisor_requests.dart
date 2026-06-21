import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/features/advisor_nav/manger/cubit/my_students_cubit.dart';
import 'package:edu_advisor/features/advisor_nav/manger/cubit/my_students_state.dart';
import 'package:edu_advisor/features/requests/data/repo/advisor_request_repo.dart';
import 'package:edu_advisor/features/requests/manager/cubit/request_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/request_state.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/empty_state.dart';
import 'package:edu_advisor/features/requests/widgets/filter_bar.dart';
import 'package:edu_advisor/features/requests/widgets/student_request_list.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvisorRequests extends StatelessWidget {
  const AdvisorRequests({super.key});

  @override
  Widget build(BuildContext context) {
    // print("TOKEN: $token");
    return BlocProvider(
      create: (context) =>
          RequestsCubit(advisorRepo: getIt<AdvisorRepo>())
            ..fetchPendingRequests(),
      // 💡 استخدام الـ Builder لضمان تمرير الـ Context المشبع بالـ Cubit للشاشات الفرعية والتفاصيل بشكل سليم
      child: Builder(builder: (context) => _AdvisorRequestsView()),
    );
  }
}

class _AdvisorRequestsView extends StatefulWidget {
  const _AdvisorRequestsView();

  @override
  State<_AdvisorRequestsView> createState() => _AdvisorRequestsViewState();
}

class _AdvisorRequestsViewState extends State<_AdvisorRequestsView> {
  String _currentFilter = 'New Requests'; // التاب الافتراضي عند فتح الشاشة

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // الـ Header الخاص ببيانات المستشار وعدد الطلاب
          BlocBuilder<MyStudentsCubit, MyStudentsState>(
            builder: (context, state) {
              final count = state is MyStudentsSuccess ? state.totalCount : 0;
              return AdvisorHeader(studentCount: count);
            },
          ),

          // بار التنقل بين التابات (New Requests, Approved, Rejected)
          RequestFilterBar(
            onFilterChanged: (newStatus) {
              setState(() {
                _currentFilter = newStatus;
              });

              if (newStatus == 'Approved') {
                context.read<RequestsCubit>().fetchApprovedRequests();
              }
            },
          ),

          Expanded(
            child: BlocBuilder<RequestsCubit, RequestsState>(
              builder: (context, state) {
                if (state is RequestsLoading || state is RequestsInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is RequestsFailure) {
                  return Center(
                    child: Text(
                      'Error: ${state.failure.apiResponse.message}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }

                final successState = state as RequestsSuccess;

                final List<StudentRequest> requestsToShow;

                if (_currentFilter == 'New Requests') {
                  requestsToShow = successState.pendingRequests
                      .where((req) => req.status.toLowerCase() == 'pending')
                      .toList();
                } else if (_currentFilter == 'Approved') {
                  requestsToShow = successState.approvedRequests;
                } else {
                  // في حالة تاب Rejected
                  requestsToShow = successState.rejectedRequests;
                }

                return requestsToShow.isEmpty
                    ? const EmptyRequestsWidget()
                    : RequestsList(requests: requestsToShow.cast());
              },
            ),
          ),
        ],
      ),
    );
  }
}
