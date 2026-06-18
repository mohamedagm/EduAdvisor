import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/services/data/models/available_course_model.dart';
import 'package:edu_advisor/features/services/manager/course_registration_cubit/course_registration_cubit.dart';
import 'package:edu_advisor/features/services/manager/course_registration_cubit/course_registration_state.dart';
import 'package:edu_advisor/features/services/views/widgets/course_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AvailableCoursesSheet extends StatelessWidget {
  const AvailableCoursesSheet({
    super.key,
    required this.selectedCourseIds,
    required this.onCourseToggled,
  });

  final Set<String> selectedCourseIds;
  final ValueChanged<AvailableCourseModel> onCourseToggled;

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
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close, color: AppColors.gray500),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child:
                BlocBuilder<CourseRegistrationCubit, CourseRegistrationState>(
                  builder: (context, state) {
                    if (state is AvailableCoursesLoading ||
                        state is CourseRegistrationInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is AvailableCoursesFailure) {
                      return _AvailableCoursesError(
                        message: state.failure.message,
                      );
                    }

                    if (state is AvailableCoursesLoaded) {
                      if (state.courses.isEmpty) {
                        return const Center(
                          child: Text('No available courses.'),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.courses.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final course = state.courses[index];
                          final isSelected = selectedCourseIds.contains(
                            course.semesterCourseId,
                          );

                          return _AvailableCourseTile(
                            course: course,
                            isSelected: isSelected,
                            onTap: () => onCourseToggled(course),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
          ),
        ],
      ),
    );
  }
}

class _AvailableCourseTile extends StatelessWidget {
  const _AvailableCourseTile({
    required this.course,
    required this.isSelected,
    required this.onTap,
  });

  final AvailableCourseModel course;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.bluePrimary : AppColors.gray200,
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
                    course.displayCode,
                    style: AppTextStyles.heading3PoppinsReg16.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.displayName,
                    style: AppTextStyles.bodyInterRegular12.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${course.creditHours} Credits',
                    style: AppTextStyles.bodyInterMedium14.copyWith(
                      color: AppColors.gray900,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.bluePrimary),
          ],
        ),
      ),
    );
  }
}

class _AvailableCoursesError extends StatelessWidget {
  const _AvailableCoursesError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, color: AppColors.errorRed),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyInterMedium14.copyWith(
              color: AppColors.gray600,
            ),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: context
                .read<CourseRegistrationCubit>()
                .getAvailableCourses,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
