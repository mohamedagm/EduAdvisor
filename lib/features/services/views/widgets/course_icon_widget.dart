import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/available_course_model.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class CourseIconWidget extends StatelessWidget {
  final AvailableCourseModel course;

  const CourseIconWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: course.iconBackgroundColor ?? context.themeColors.textMuted,
        gradient: course.iconGradient,
      ),
      child: Center(child: Icon(course.icon, color: AppColors.white, size: 24)),
    );
  }
}
