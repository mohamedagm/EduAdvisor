import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/CourseCatalog/data/models/course_model.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    spacing: 24,
                    children: [
                      Text(
                        course.displayCode,
                        style: AppTextStyles.heading3PoppinsReg16.copyWith(
                          color: context.themeColors.textPrimary,
                        ),
                      ),
                      Container(
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
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: context.themeColors.warning,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.themeColors.mutedSurface,
                    ),
                    child: IconButton(
                      onPressed: () => context.pop(),
                      padding: EdgeInsets.zero,
                      icon: const Icon(Icons.close, size: 20),
                    ),
                  ),
                ],
              ),

              Text(
                course.displayName,
                style: AppTextStyles.poppinsRegular14.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),

              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 12),

              _SectionTitle(
                icon: Icons.menu_book_outlined,
                label: 'Description',
              ),

              const SizedBox(height: 6),

              Text(
                course.displayDescription,
                style: AppTextStyles.interRegular16.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),

              const SizedBox(height: 16),

              _SectionTitle(
                icon: Icons.school_outlined,
                label: 'Academic Placement',
                iconColor: context.themeColors.warning,
              ),

              const SizedBox(height: 6),

              Text(
                'Level ${course.standardLevel}, semester ${course.standardSemester}.',
                style: AppTextStyles.interRegular16.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),

              const SizedBox(height: 16),

              _SectionTitle(
                icon: Icons.account_tree_outlined,
                label: 'Department',
                iconColor: context.themeColors.success,
              ),

              const SizedBox(height: 6),

              Text(
                course.displayDepartment,
                style: AppTextStyles.interRegular16.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Specializations',
                style: AppTextStyles.heading3PoppinsReg16.copyWith(
                  color: context.themeColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Tag(label: course.displayType),
                  Tag(label: course.displayDepartment),
                ],
              ),

              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _InfoTile(
                      title: 'Credits',
                      value: course.displayCreditHours,
                    ),
                  ),
                  Expanded(
                    child: _InfoTile(
                      title: 'Semester',
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
        Icon(icon, size: 24, color: iconColor ?? context.themeColors.textMuted),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.heading3PoppinsReg16.copyWith(
            color: context.themeColors.textPrimary,
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
          style: AppTextStyles.bodyInterMedium18.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.interRegular16.copyWith(
            color: context.themeColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
