import 'package:flutter/material.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import '../../data/models/available_course_model.dart';
import 'course_icon_widget.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedCourseItem extends StatelessWidget {
  final AvailableCourseModel course;
  final VoidCallback onRemove;

  const SelectedCourseItem({
    super.key,
    required this.course,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.only(bottom: 12.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseIconWidget(course: course),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.displayCode,
                      style: AppTextStyles.heading3PoppinsReg16.responsive
                          .copyWith(color: context.themeColors.textPrimary),
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      course.courseName.isNotEmpty
                          ? course.courseName
                          : context.l10n.courseFallbackName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                        color: context.themeColors.textMuted,
                      ),
                    ),
                    SizedBox(height: 12.w),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.w,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: context.themeColors.card,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: context.colorScheme.outline,
                            ),
                          ),
                          child: Text(
                            context.l10n.courseLevel(course.level.toString()),
                            style: AppTextStyles.bodyInterRegular12.responsive
                                .copyWith(
                                  color: context.themeColors.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: Icon(
                  Icons.delete_outline,
                  color: context.colorScheme.error,
                  size: 20.r,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
