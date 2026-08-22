import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/course_request_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestHeaderSection extends StatelessWidget {
  final StudentRequest request;

  const RequestHeaderSection({super.key, required this.request});

  Color _getStatusColor(BuildContext context) {
    switch (request.status) {
      case 2:
        return context.themeColors.success;
      case 1:
        return context.themeColors.warning;
      case 3:
      default:
        return context.colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "${request.semesterName} Requests",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "STATUS: ${request.statusName.toUpperCase()}",
          style: TextStyle(
            color: _getStatusColor(context),
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }
}

class CoursesListView extends StatelessWidget {
  final StudentRequest request;

  const CoursesListView({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: request.enrollments.length,
      itemBuilder: (context, index) {
        final enrollment = request.enrollments[index];
        final dateFormatted =
            "${request.submittedAt.day}/${request.submittedAt.month}/${request.submittedAt.year}";

        return CourseRequestCard(
          code: enrollment.courseCode,
          name: enrollment.courseName,
          credits: enrollment.creditHours,
          date: dateFormatted,
        );
      },
    );
  }
}