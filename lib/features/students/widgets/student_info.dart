


import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class StudentInfo extends StatelessWidget {
  final String fullName;
  final String email;

  const StudentInfo({super.key, required this.fullName, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(fullName,
            style:  AppTextStyles.interRegular16.copyWith(color: AppColors.gray600)),
        const SizedBox(height: 3),
        Text(email,
            style: AppTextStyles.bodyInterMedium14.copyWith(color: AppColors.gray400)),
      ],
    );
  }
}




//Student Meta (GPA and Semester)
class StudentMeta extends StatelessWidget {
  final double gpa;
  final int semester;

  const StudentMeta({super.key, required this.gpa, required this.semester});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'GPA: ${gpa.toStringAsFixed(1)}',
          style:AppTextStyles.interRegular16.copyWith(color: AppColors.gray600),
        ),
        const SizedBox(height: 4),
        Text(
          'Semester $semester',
          style: AppTextStyles.bodyInterMedium14.copyWith(color: AppColors.gray400),
        ),
      ],
    );
  }
}