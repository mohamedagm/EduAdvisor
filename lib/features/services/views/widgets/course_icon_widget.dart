import 'package:flutter/material.dart';
import '../../data/models/available_course_model.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseIconWidget extends StatelessWidget {
  final AvailableCourseModel course;

  const CourseIconWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Container(
      width: 48.r,
      height: 48.r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: colors.infoContainer,
      ),
      child: Center(
        child: Icon(Icons.menu_book, color: colors.onInfoContainer, size: 24.r),
      ),
    );
  }
}
