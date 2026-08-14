import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/advisor_nav/data/models/my_students_response_model.dart';
import 'package:edu_advisor/features/students/widgets/student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        SizedBox(width: 16.w),
        Expanded(
          child: Container(
            height: 40.w,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: context.themeColors.mutedSurface,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  size: 18.r,
                  color: context.themeColors.textMuted,
                ),
                SizedBox(width: 8.w),
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
 
  final List<MyStudentModel> students;

  const StudentList({super.key, required this.students});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 14.w),
      itemCount: students.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.w), 
      itemBuilder: (context, index) {
       
        return StudentCard(student: students[index]);
      },
    );
  }
}
