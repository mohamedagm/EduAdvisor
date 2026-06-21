import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/advisor_nav/data/models/my_students_response_model.dart';
import 'package:edu_advisor/features/students/models/student_model.dart';
import 'package:edu_advisor/features/students/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class SearchRow extends StatelessWidget {
  final TextEditingController controller;

  const SearchRow({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'My Students',
          style: AppTextStyles.heading3PoppinsReg16.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: context.themeColors.mutedSurface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 18,
                  color: context.themeColors.textMuted,
                ),
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
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// STUDENT LIST


class StudentList extends StatelessWidget {
  // 1. التغيير هنا: بنخلي الـ List تستقبل الموديل الحقيقي اللي جاي من السيرفر
  final List<MyStudentModel> students;

  const StudentList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 14),
      itemCount: students.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10), // المسافة بين الكروت
      itemBuilder: (context, index) {
        // 2. التغيير هنا: بنمرر الطالب اللي عليه الدور في الـ Loop للكارت بتاعه باستخدام الـ index
        return StudentCard(student: students[index]);
      },
    );
  }
}
