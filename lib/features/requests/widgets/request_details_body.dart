import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/request_details_widgets.dart';
import 'package:edu_advisor/features/requests/widgets/student_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestDetailsBody extends StatelessWidget {
  final StudentRequest request;

  const RequestDetailsBody({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StudentInfoCard(
            studentName: request.studentName,
            studentCode: request.studentCode,
            department: request.semesterName,
            academicYear: request.totalCreditHours,
            photoUrl: null,
          ),
          SizedBox(height: 24.w),
          RequestHeaderSection(request: request),
          SizedBox(height: 16.w),
          CoursesListView(request: request),
          SizedBox(height: 100.w),
        ],
      ),
    );
  }
}