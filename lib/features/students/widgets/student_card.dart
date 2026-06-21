import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/features/advisor_nav/data/models/my_students_response_model.dart';
import 'package:edu_advisor/features/students/widgets/student_info.dart';
import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final MyStudentModel student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.gray200, width: 0.8),
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
