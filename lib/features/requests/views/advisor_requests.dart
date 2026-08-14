import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvisorRequests extends StatelessWidget {
  const AdvisorRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RequestsCubit(advisorRepo: getIt<AdvisorRequestRepo>())
            ..fetchPendingRequests(),
      child: Builder(builder: (context) => const _AdvisorRequestsView()),
    );
  }
}

class _AdvisorRequestsView extends StatefulWidget {
  const _AdvisorRequestsView();

  @override
  State<_AdvisorRequestsView> createState() => _AdvisorRequestsViewState();
}

class _AdvisorRequestsViewState extends State<_AdvisorRequestsView> {
  String _currentFilter = 'New Requests'; 
  final TextEditingController _searchController = TextEditingController();

  String _getMappedStatus(String filter) {
    if (filter == 'New Requests') return 'Pending';
    return filter; 
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BlocBuilder<MyStudentsCubit, MyStudentsState>(
            builder: (context, state) {
              final count = state is MyStudentsSuccess ? state.totalCount : 0;
              return AdvisorHeader(studentCount: count);
            },
          ),

          // حقل البحث الذكي متوافق بالكامل مع السيرفر والـ Cubit الحالي
          if (_currentFilter != 'New Requests')
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by student name...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            context.read<RequestsCubit>().searchRequests(
                                  '',
                                  currentStatus: _getMappedStatus(_currentFilter),
                                );
                            setState(() {});
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 0.w),
                ),
                onChanged: (value) {
                  setState(() {}); 
                  context.read<RequestsCubit>().searchRequests(
                        value,
                        currentStatus: _getMappedStatus(_currentFilter),
                      );
                },
              ),
            ),

          RequestFilterBar(
            onFilterChanged: (newStatus) {
              setState(() {
                _currentFilter = newStatus;
                _searchController.clear(); 
              });

              if (newStatus == 'New Requests') {
                context.read<RequestsCubit>().fetchPendingRequests();
              } else if (newStatus == 'Approved') {
                context.read<RequestsCubit>().fetchApprovedRequests();
              } else if (newStatus == 'Rejected') {
                context.read<RequestsCubit>().fetchRejectedRequests();
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
                      style: TextStyle(color: context.colorScheme.error),
                    ),
                  );
                }

                final successState = state as RequestsSuccess;
                final List<StudentRequest> requestsToShow;

                if (_currentFilter == 'New Requests') {
                  requestsToShow = successState.pendingRequests;
                } else if (_currentFilter == 'Approved') {
                  requestsToShow = successState.approvedRequests;
                } else {
                  requestsToShow = successState.rejectedRequests;
                }

                return requestsToShow.isEmpty
                    ? const EmptyRequestsWidget()
                    : RequestsList(requests: requestsToShow);
              },
            ),
          ),
        ],
      ),
    );
  }
}