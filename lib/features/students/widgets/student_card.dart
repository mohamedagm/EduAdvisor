import 'package:edu_advisor/features/students/models/student_model.dart';
import 'package:edu_advisor/features/students/widgets/student_info.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class StudentCard extends StatelessWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: context.themeColors.border, width: 0.8),
      ),
      child: Row(
        children: [
          Expanded(
            child: StudentInfo(
              fullName: student.fullName,
              email: student.email,
            ),
          ),
          StudentMeta(gpa: student.gpa, semester: student.semester),
        ],
      ),
    );
  }
}
