import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/course.dart';
import 'course_icon_widget.dart';

class SelectedCourseItem extends StatelessWidget {
  final Course course;
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
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CourseIconWidget(course: course),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.id,
                      style: AppTextStyles.heading3PoppinsReg16.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.name,
                      style: AppTextStyles.poppinsRegular14.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.gray300),
                          ),
                          child: Text(
                            '${course.credits} Credits',
                            style: AppTextStyles.bodyInterRegular12.copyWith(
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (course.prerequisites.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.blueLight,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: AppColors.bluePrimary.withValues(alpha: 0.2)),
                            ),
                            child: Text(
                              'Has Prerequisites',
                              style: AppTextStyles.bodyInterRegular12.copyWith(
                                color: AppColors.bluePrimary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onRemove,
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.errorRed,
                  size: 20,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          if (course.prerequisites.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Prerequisites: ${course.prerequisites.join(", ")}',
              style: AppTextStyles.bodyInterRegular12.copyWith(
                color: AppColors.gray500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
