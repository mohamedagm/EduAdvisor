import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/services/data/models/available_course_model.dart';
import 'package:edu_advisor/features/services/manager/course_registration_cubit/course_registration_cubit.dart';
import 'package:edu_advisor/features/services/manager/course_registration_cubit/course_registration_state.dart';
import 'package:edu_advisor/features/services/views/widgets/course_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.all(24.w),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.l10n.availableCourses,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading1_20b.responsive.copyWith(
                    color: context.themeColors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.close,
                  size: 24.r,
                  color: context.themeColors.textMuted,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: 24.w),
          Expanded(
            child:
                BlocBuilder<CourseRegistrationCubit, CourseRegistrationState>(
                  builder: (context, state) {
                    if (state is AvailableCoursesLoading ||
                        state is CourseRegistrationInitial) {
                      return const _AvailableCoursesShimmer();
                    }

                    if (state is AvailableCoursesFailure) {
                      return _AvailableCoursesError(
                        message: state.failure.message,
                      );
                    }

                    if (state is AvailableCoursesLoaded) {
                      if (state.courses.isEmpty) {
                        return Center(
                          child: Text(
                            context.l10n.noAvailableCourses,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyInterMedium14.responsive,
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.courses.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.w),
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

class _AvailableCoursesShimmer extends StatelessWidget {
  const _AvailableCoursesShimmer();

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        separatorBuilder: (context, index) => SizedBox(height: 12.w),
        itemBuilder: (context, index) => const _AvailableCourseSkeletonTile(),
      ),
    );
  }
}

class _AvailableCourseSkeletonTile extends StatelessWidget {
  const _AvailableCourseSkeletonTile();

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
        children: [
          AppShimmerBox(width: 48.r, height: 48.r, borderRadius: 12.r),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerBox(width: 74.w, height: 16.w),
                SizedBox(height: 7.w),
                AppShimmerBox(height: 13.w),
                SizedBox(height: 9.w),
                AppShimmerBox(width: 68.w, height: 13.w),
              ],
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
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.themeColors.card,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? context.colorScheme.primary
                : context.themeColors.border,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          children: [
            CourseIconWidget(course: course),
            SizedBox(width: 16.w),
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
                    style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                      color: context.themeColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    context.l10n.courseLevel(course.level.toString()),
                    style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                      color: context.themeColors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                size: 24.r,
                color: context.colorScheme.primary,
              ),
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
          Icon(
            Icons.error_outline,
            size: 24.r,
            color: context.colorScheme.error,
          ),
          SizedBox(height: 8.w),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
              color: context.themeColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.w),
          TextButton(
            onPressed: context
                .read<CourseRegistrationCubit>()
                .getAvailableCourses,
            child: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }
}
