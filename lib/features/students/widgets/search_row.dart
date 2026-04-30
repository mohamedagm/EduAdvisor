import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/students/models/student_model.dart';
import 'package:edu_advisor/features/students/widgets/student_card.dart';
import 'package:flutter/material.dart';

class SearchRow extends StatelessWidget {
  final TextEditingController controller;

  const SearchRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
     
      children: [
         Text('My Students',
            style: AppTextStyles.heading3PoppinsReg16.copyWith(color: AppColors.gray800)),
      SizedBox(width: 16),
        Expanded(
  child: Container(
    height: 40,
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      color: AppColors.gray100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Icon(Icons.search, size: 18, color: AppColors.gray400),
        SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Search students...',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  ),
)
      ],
    );
  }
}

// ─────────────────────────────────────────────
// STUDENT LIST
// ─────────────────────────────────────────────

class StudentList extends StatelessWidget {
  final List<Student> students;

  const StudentList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
       padding: EdgeInsets.symmetric(vertical: 14),
      itemCount: students.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),///space between cards
      itemBuilder: (context, index) =>
          StudentCard(student: students[index]),
    );
  }
}