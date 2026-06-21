import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/profile/data/models/student_course_model.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCourseCard extends StatelessWidget {
  const ProfileCourseCard({super.key, required this.course});

  final StudentCourseModel course;

  @override
  Widget build(BuildContext context) {
    final progress = course.progress;

    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: context.themeColors.infoContainer,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.themeColors.info.withValues(alpha: 0.2),
          width: 2.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: context.themeColors.info.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.access_time_rounded,
                  color: context.themeColors.info,
                  size: 22.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.displayCode,
                      style: AppTextStyles.heading3PoppinsReg16.responsive,
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      course.name.isNotEmpty
                          ? course.name
                          : context.l10n.courseFallbackName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                        color: context.themeColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: AppTextStyles.interRegular16.responsive.copyWith(
                      color: context.themeColors.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    context.l10n.creditHoursShort(course.displayCreditHours),
                    style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                      color: context.themeColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.w),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10.r),
            value: progress,
            minHeight: 8.w,
            color: context.themeColors.textPrimary,
            backgroundColor: context.colorScheme.outline,
          ),
        ],
      ),
    );
  }
}
