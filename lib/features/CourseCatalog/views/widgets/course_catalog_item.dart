import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/CourseCatalog/data/models/course_model.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCatalogItem extends StatelessWidget {
  const CourseCatalogItem({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 8.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 4.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                course.displayCode,
                                style: AppTextStyles
                                    .heading3PoppinsReg16
                                    .responsive
                                    .copyWith(
                                      color: context.themeColors.textPrimary,
                                    ),
                              ),
                              SizedBox(width: 12.w),
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 2.w,
                                  ),
                                  decoration: BoxDecoration(
                                    color: context.themeColors.warningContainer,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    course.displayType,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles
                                        .bodyInterRegular12
                                        .responsive
                                        .copyWith(
                                          color: context.themeColors.warning,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          Text(
                            course.displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.interRegular16.responsive
                                .copyWith(
                                  color: context.themeColors.textSecondary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 24.r,
                      color: context.themeColors.textMuted,
                    ),
                  ],
                ),

                Wrap(
                  spacing: 16.w,
                  runSpacing: 8.w,
                  children: [
                    _CourseMetadata(
                      icon: Icons.menu_book_outlined,
                      label: context.l10n.courseCredits(
                        course.displayCreditHours,
                      ),
                    ),
                    _CourseMetadata(
                      icon: Icons.school_outlined,
                      label: context.l10n.courseLevel(
                        course.standardLevel.toString(),
                      ),
                    ),
                  ],
                ),

                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.w,
                  children: [
                    Tag(label: course.displayDepartment),
                    Tag(
                      label: context.l10n.courseSemester(
                        course.standardSemester.toString(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseMetadata extends StatelessWidget {
  const _CourseMetadata({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.r, color: context.themeColors.textMuted),
        SizedBox(width: 4.w),
        Text(label, style: AppTextStyles.bodyInterMedium14.responsive),
      ],
    );
  }
}
