import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/CourseCatalog/data/models/course_model.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class CourseCatalogItem extends StatelessWidget {
  const CourseCatalogItem({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              spacing: 8,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                course.displayCode,
                                style: AppTextStyles.heading3PoppinsReg16
                                    .copyWith(
                                      color: context.themeColors.textPrimary,
                                    ),
                              ),
                              const SizedBox(width: 24),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: context.themeColors.warningContainer,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    course.displayType,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.bodyInterRegular12
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
                            style: AppTextStyles.interRegular16.copyWith(
                              color: context.themeColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: context.themeColors.textMuted,
                    ),
                  ],
                ),

                Row(
                  children: [
                    Icon(
                      Icons.menu_book_outlined,
                      size: 16,
                      color: context.themeColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${course.displayCreditHours} Credits',
                      style: AppTextStyles.bodyInterMedium14,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.school_outlined,
                      size: 16,
                      color: context.themeColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Level ${course.standardLevel}',
                      style: AppTextStyles.bodyInterMedium14,
                    ),
                  ],
                ),

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Tag(label: course.displayDepartment),
                    Tag(label: 'Semester ${course.standardSemester}'),
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
