import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/empty_state.dart';
import 'package:edu_advisor/features/requests/widgets/filter_bar.dart';
import 'package:edu_advisor/features/requests/widgets/student_request_list.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';

class AdvisorRequests extends StatefulWidget {
  final List<StudentRequest> allRequests;

  const AdvisorRequests({super.key, required this.allRequests});

  @override
  State<AdvisorRequests> createState() => _AdvisorRequestsState();
}

class _AdvisorRequestsState extends State<AdvisorRequests> {
  // الحالة الافتراضية عند فتح الصفحة
  String _currentFilter = 'New Requests';

  @override
  Widget build(BuildContext context) {
    final filteredList = widget.allRequests.where((req) {
      if (_currentFilter == 'New Requests') {
        return req.status.toLowerCase() == 'pending';
      } else if (_currentFilter == 'Approved') {
        return req.status.toLowerCase() == 'approved';
      } else if (_currentFilter == 'Rejected') {
        return req.status.toLowerCase() == 'rejected';
      }
      return true;
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          const AdvisorHeader(),

          RequestFilterBar(
            onFilterChanged: (newStatus) {
              setState(() {
                _currentFilter = newStatus;
              });
            },
          ),

          Expanded(
            child: filteredList.isEmpty
                ? const EmptyRequestsWidget()
                : RequestsList(requests: filteredList),
          ),
        ],
      ),
    );
  }
}
