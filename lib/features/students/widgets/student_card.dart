import 'package:edu_advisor/features/advisor_nav/data/models/my_students_response_model.dart';
import 'package:edu_advisor/features/students/widgets/student_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class StudentCard extends StatelessWidget {
  final MyStudentModel student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: context.themeColors.border, width: 0.8.w),
      ),
      child: Row(
        children: [
          Expanded(
            child: StudentInfo(
              fullName: student.name,
              email: student.email,
              imageUrl: student.imageUrl,
            ),
          ),

          StudentMeta(gpa: student.gpa, semester: student.semester),
        ],
      ),
    );
  }
}
