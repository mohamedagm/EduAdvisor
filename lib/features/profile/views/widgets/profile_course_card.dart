import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/profile/data/models/student_enrollment_model.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCourseCard extends StatelessWidget {
  const ProfileCourseCard({super.key, required this.course});

  final StudentEnrollmentModel course;

  @override
  Widget build(BuildContext context) {
    final name = course.nameFor(Localizations.localeOf(context));
    final hasGrade = course.hasGrade;
    final gpa = course.courseGpa?.toDouble();
    final progress = course.progressValue;

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
                  Icons.menu_book_outlined,
                  color: context.themeColors.info,
                  size: 22.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  name.isNotEmpty ? name : context.l10n.courseFallbackName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading3PoppinsReg16.responsive,
                ),
              ),
              SizedBox(width: 8.w),
              if (hasGrade)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.w,
                  ),
                  decoration: BoxDecoration(
                    color: _gpaColor(context, gpa!).withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: _gpaColor(context, gpa).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    'GPA $gpa',
                    style: AppTextStyles.interRegular16.responsive.copyWith(
                      fontSize: 12.sp,
                      color: _gpaColor(context, gpa),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 10.w),
          Row(
            children: [
              Text(
                context.l10n.creditHoursShort(course.creditHours.toString()),
                style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),
              if (course.coursePercentage != null) ...[
                const Spacer(),
                Text(
                  '${course.coursePercentage!.toStringAsFixed(0)}%',
                  style: AppTextStyles.interRegular16.responsive.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: context.themeColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
          if (progress != null) ...[
            SizedBox(height: 8.w),
            LinearProgressIndicator(
              borderRadius: BorderRadius.circular(10.r),
              value: progress,
              minHeight: 6.w,
              color: context.themeColors.info,
              backgroundColor: context.colorScheme.outline,
            ),
          ],
        ],
      ),
    );
  }

  Color _gpaColor(BuildContext context, double gpa) {
    if (gpa >= 3.0) return context.themeColors.success;
    if (gpa >= 2.0) return context.themeColors.warning;
    return context.colorScheme.error;
  }
}
