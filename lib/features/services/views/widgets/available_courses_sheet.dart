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
                      final courses = state.response.courses;

                      if (courses.isEmpty) {
                        return Center(
                          child: Text(
                            context.l10n.noAvailableCourses,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyInterMedium14.responsive,
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: courses.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.w),
                        itemBuilder: (context, index) {
                          final course = courses[index];
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
          SizedBox(height: 16.w),
          BlocBuilder<CourseRegistrationCubit, CourseRegistrationState>(
            builder: (context, state) {
              if (state is! AvailableCoursesLoaded) return const SizedBox.shrink();

              final min = state.response.minHours;
              final max = state.response.maxHours;

              final selected = state.response.courses
                  .where(
                    (c) => selectedCourseIds.contains(c.semesterCourseId),
                  )
                  .toList();
              final totalCredits =
                  selected.fold(0, (sum, c) => sum + c.creditHours);
              final isValid = totalCredits >= min && totalCredits <= max;

              return _SelectedHoursFooter(
                totalCredits: totalCredits,
                min: min,
                max: max,
                isValid: isValid,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SelectedHoursFooter extends StatelessWidget {
  const _SelectedHoursFooter({
    required this.totalCredits,
    required this.min,
    required this.max,
    required this.isValid,
  });

  final int totalCredits;
  final int min;
  final int max;
  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.mutedSurface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.info_outline,
            size: 20.r,
            color: isValid
                ? context.themeColors.success
                : context.colorScheme.error,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              isValid
                  ? context.l10n.validSelectionString(totalCredits)
                  : context.l10n.invalidSelectionString(totalCredits, min, max),
              style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                color: isValid
                    ? context.themeColors.success
                    : context.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
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
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          course.courseCode,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              AppTextStyles.heading3PoppinsReg16.responsive
                                  .copyWith(
                                    color: context.themeColors.textPrimary,
                                  ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: context.themeColors.infoContainer,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          course.typeLabel,
                          style: TextStyle(
                            color: context.themeColors.onInfoContainer,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (course.attemptCount > 0) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: context.themeColors.warningContainer,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            context.l10n.attemptNumber(
                              course.attemptCount + 1,
                            ),
                            style: TextStyle(
                              color: context.themeColors.onWarningContainer,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    course.nameFor(Localizations.localeOf(context)),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                      color: context.themeColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    context.l10n.creditHoursShort(
                      course.creditHours.toString(),
                    ),
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
            onPressed:
                context.read<CourseRegistrationCubit>().getAvailableCourses,
            child: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }
}
