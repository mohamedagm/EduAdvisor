import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/student_request_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestsList extends StatelessWidget {
  final List<StudentRequest> requests;

  const RequestsList({super.key, required this.requests});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: false,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: requests.length,
      separatorBuilder: (_, __) => SizedBox(height: 1.w),
      itemBuilder: (context, index) {
        return StudentRequestCard(request: requests[index]);
      },
    );
  }
}
