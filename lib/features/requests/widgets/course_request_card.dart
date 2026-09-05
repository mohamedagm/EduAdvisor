import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/features/requests/manager/cubit/prerequisites_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/prerequisites_state.dart';
import 'package:edu_advisor/features/requests/manager/cubit/student_hestory_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/student_history_state.dart';
import 'package:edu_advisor/features/requests/models/prerequisite_model.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/course_history_utils.dart';
import 'package:edu_advisor/features/requests/widgets/prerequisites_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseRequestCard extends StatelessWidget {
  final EnrollmentModel enrollment;

  const CourseRequestCard({super.key, required this.enrollment});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<PrerequisitesCubit>()
            ..fetchCoursePrerequisites(enrollment.courseId),
      child: BlocBuilder<PrerequisitesCubit, PrerequisitesState>(
        builder: (context, prereqState) {
          return BlocBuilder<StudentHistoryCubit, StudentHistoryState>(
            builder: (context, historyState) {
              final bestGpaPerCourse = historyState is StudentHistorySuccess
                  ? buildBestGpaPerCourse(historyState.history)
                  : <String, double>{};

             final List<PrerequisiteCourseModel> prerequisites =
    prereqState is PrerequisitesSuccessState
        ? prereqState.prerequisites
        : const [];

              final bool hasPrerequisites = prerequisites.isNotEmpty;
              final bool isLoading =
                  prereqState is PrerequisitesLoadingState ||
                  historyState is StudentHistoryLoading;

              return Container(
                margin: EdgeInsets.only(bottom: 12.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: hasPrerequisites
                      ? context.themeColors.warningContainer
                      : context.themeColors.card,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: hasPrerequisites
                        ? context.themeColors.warning.withValues(alpha: 0.35)
                        : context.themeColors.mutedSurface,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _CourseHeader(courseCode: enrollment.courseCode),
                    SizedBox(height: 10.w),
                    Text(
                      enrollment.courseName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _CreditHoursRow(
                      creditHours: enrollment.creditHours,
                      isLoading: isLoading,
                      hasPrerequisites: hasPrerequisites,
                    ),
                    if (hasPrerequisites) ...[
                      const SizedBox(height: 12),
                      PrerequisitesSection(
                        prerequisites: prerequisites,
                        bestGpaPerCourse: bestGpaPerCourse,
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _CourseHeader extends StatelessWidget {
  final String courseCode;

  const _CourseHeader({required this.courseCode});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.menu_book_rounded,
              color: context.colorScheme.primary,
              size: 18.r,
            ),
            const SizedBox(width: 8),
            Text(
              courseCode,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: context.colorScheme.primary,
              ),
            ),
          ],
        ),
        Text(
          "Requested",
          style: TextStyle(
            color: context.themeColors.textMuted,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _CreditHoursRow extends StatelessWidget {
  final int creditHours;
  final bool isLoading;
  final bool hasPrerequisites;

  const _CreditHoursRow({
    required this.creditHours,
    required this.isLoading,
    required this.hasPrerequisites,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.stars_rounded,
          size: 16,
          color: context.themeColors.textMuted,
        ),
        const SizedBox(width: 4),
        Text(
          "$creditHours Credits",
          style: TextStyle(
            color: context.themeColors.textSecondary,
            fontSize: 13,
          ),
        ),
        if (isLoading) ...[
          SizedBox(width: 16.w),
          SizedBox(
            width: 12.r,
            height: 12.r,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
        ] else if (hasPrerequisites) ...[
          SizedBox(width: 16.w),
          Icon(
            Icons.info_outline_rounded,
            color: context.themeColors.warning,
            size: 16,
          ),
          SizedBox(width: 4.w),
          Text(
            "Has Prerequisites",
            style: TextStyle(
              color: context.themeColors.warning,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}