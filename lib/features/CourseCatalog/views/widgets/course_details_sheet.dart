import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/CourseCatalog/data/models/course_model.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseDetailsSheet extends StatelessWidget {
  const CourseDetailsSheet({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (_, controller) {
        return SingleChildScrollView(
          controller: controller,
          padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            course.displayCode,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading3PoppinsReg16.responsive
                                .copyWith(
                                  color: context.themeColors.textPrimary,
                                ),
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
                              style: AppTextStyles.bodyInterRegular12.responsive
                                  .copyWith(color: context.themeColors.warning),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    height: 32.r,
                    width: 32.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.themeColors.mutedSurface,
                    ),
                    child: IconButton(
                      onPressed: () => context.pop(),
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.close, size: 20.r),
                    ),
                  ),
                ],
              ),

              Text(
                course.displayName,
                style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),

              SizedBox(height: 16.w),
              const Divider(),
              SizedBox(height: 12.w),

              _SectionTitle(
                icon: Icons.menu_book_outlined,
                label: context.l10n.courseDescription,
              ),

              SizedBox(height: 6.w),

              Text(
                course.displayDescription,
                style: AppTextStyles.interRegular16.responsive.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),

              SizedBox(height: 16.w),

              _SectionTitle(
                icon: Icons.school_outlined,
                label: context.l10n.academicPlacement,
                iconColor: context.themeColors.warning,
              ),

              SizedBox(height: 6.w),

              Text(
                context.l10n.courseAcademicPlacement(
                  course.standardLevel.toString(),
                  course.standardSemester.toString(),
                ),
                style: AppTextStyles.interRegular16.responsive.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),

              SizedBox(height: 16.w),

              _SectionTitle(
                icon: Icons.account_tree_outlined,
                label: context.l10n.department,
                iconColor: context.themeColors.success,
              ),

              SizedBox(height: 6.w),

              Text(
                course.displayDepartment,
                style: AppTextStyles.interRegular16.responsive.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),

              SizedBox(height: 16.w),

              Text(
                context.l10n.specializations,
                style: AppTextStyles.heading3PoppinsReg16.responsive.copyWith(
                  color: context.themeColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.w),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.w,
                children: [
                  Tag(label: course.displayType),
                  Tag(label: course.displayDepartment),
                ],
              ),

              SizedBox(height: 20.w),
              const Divider(),
              SizedBox(height: 12.w),

              Row(
                children: [
                  Expanded(
                    child: _InfoTile(
                      title: context.l10n.creditsLabel,
                      value: course.displayCreditHours,
                    ),
                  ),
                  Expanded(
                    child: _InfoTile(
                      title: context.l10n.semester,
                      value: course.standardSemester.toString(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;

  const _SectionTitle({
    required this.icon,
    required this.label,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 24.r,
          color: iconColor ?? context.themeColors.textMuted,
        ),
        SizedBox(width: 6.w),
        Expanded(
          child: Text(
            label,
            style: AppTextStyles.heading3PoppinsReg16.responsive.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String title;
  final String value;
  const _InfoTile({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyInterMedium18.responsive.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
        SizedBox(height: 4.w),
        Text(
          value,
          style: AppTextStyles.interRegular16.responsive.copyWith(
            color: context.themeColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
