import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/available_course_model.dart';
import 'course_icon_widget.dart';

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
                      course.displayCode,
                      style: AppTextStyles.heading3PoppinsReg16.copyWith(
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      course.displayName,
                      style: AppTextStyles.poppinsRegular14.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.gray300),
                          ),
                          child: Text(
                            '${course.creditHours} Credits',
                            style: AppTextStyles.bodyInterRegular12.copyWith(
                              color: AppColors.gray900,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (course.isRetake) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.blueLight,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.bluePrimary.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ),
                            child: Text(
                              'Retake',
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
          if (course.isRetake) ...[
            const SizedBox(height: 12),
            Text(
              'This course is marked as a retake.',
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
