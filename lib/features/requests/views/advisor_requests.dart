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
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  String? _currentFilter;
  final TextEditingController _searchController = TextEditingController();

  int _getMappedStatus(BuildContext context, String filter) {
    if (filter == context.l10n.approved) return 2;
    if (filter == context.l10n.rejected) return 3;
    return 1; // New Requests / Pending
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

          RequestFilterBar(
            onFilterChanged: (newStatus) {
              setState(() {
                _currentFilter = newStatus;
                _searchController.clear();
              });

              final mappedStatus = _getMappedStatus(context, newStatus);
              context.read<RequestsCubit>().fetchRequests(status: mappedStatus);
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
                      context.l10n.errorPrefix(
                        state.failure.apiResponse.message,
                      ),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  );
                }

                final successState = state as RequestsSuccess;
                final List<StudentRequest> requestsToShow;

                final currentFilter =
                    _currentFilter ?? context.l10n.newRequests;
                if (currentFilter == context.l10n.newRequests) {
                  requestsToShow = successState.pendingRequests;
                } else if (currentFilter == context.l10n.approved) {
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
