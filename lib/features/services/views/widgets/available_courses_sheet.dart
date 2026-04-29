import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../models/course.dart';
import 'course_icon_widget.dart';

class AvailableCoursesSheet extends StatelessWidget {
  final Set<String> selectedCourseIds;
  final Function(Course) onCourseToggled;

  const AvailableCoursesSheet({
    super.key,
    required this.selectedCourseIds,
    required this.onCourseToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Courses',
                style: AppTextStyles.heading1_20b.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: AppColors.gray500),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.separated(
              itemCount: mockAvailableCourses.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final course = mockAvailableCourses[index];
                final isSelected = selectedCourseIds.contains(course.id);

                return GestureDetector(
                  onTap: () {
                    onCourseToggled(course);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.bluePrimary
                            : AppColors.gray200,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        CourseIconWidget(course: course),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.id,
                                style: AppTextStyles.heading3PoppinsReg16
                                    .copyWith(color: AppColors.gray900),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                course.name,
                                style: AppTextStyles.bodyInterRegular12
                                    .copyWith(color: AppColors.gray500),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${course.credits} Credits',
                                style: AppTextStyles.bodyInterMedium14.copyWith(
                                  color: AppColors.gray900,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_circle,
                            color: AppColors.bluePrimary,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
