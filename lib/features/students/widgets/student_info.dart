import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class StudentInfo extends StatelessWidget {
  final String fullName;
  final String studentCode;

  const StudentInfo({
    super.key,
    required this.fullName,
    required this.studentCode,
  });

  String get _initials {
    final parts = fullName.trim().split(' ');
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length >= 2 && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundColor: context.themeColors.mutedSurface,
          child: Text(
            _initials,
            style: AppTextStyles.interRegular16.copyWith(
              fontSize: 16.sp,
              color: context.themeColors.textPrimary,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                fullName,
                style: AppTextStyles.interRegular16.copyWith(
                  color: context.themeColors.textPrimary,
                ),
              ),
              SizedBox(height: 3.w),
              Text(
                studentCode,
                style: AppTextStyles.bodyInterMedium14.copyWith(
                  fontSize: 14.sp,
                  color: context.themeColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StudentMeta extends StatelessWidget {
  final double gpa;
  final int academicYear;

  const StudentMeta({super.key, required this.gpa, required this.academicYear});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'GPA: ${gpa.toStringAsFixed(1)}',
          style: AppTextStyles.interRegular16.copyWith(
            fontSize: 16.sp,
            color: context.themeColors.textSecondary,
          ),
        ),
        SizedBox(height: 4.w),
        Text(
          'Year $academicYear',
          style: AppTextStyles.bodyInterMedium14.copyWith(
            fontSize: 14.sp,
            color: context.themeColors.textMuted,
          ),
        ),
      ],
    );
  }
}
