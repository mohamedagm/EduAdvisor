import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/features/requests/manager/cubit/prerequisites_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/prerequisites_state.dart';
import 'package:edu_advisor/features/requests/manager/cubit/student_hestory_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/student_history_state.dart';
import 'package:edu_advisor/features/requests/models/prerequisite_model.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
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
              // 👈 نجمّع أعلى GPA حصل عليه الطالب في كل مادة عبر كل الترمات
              final Map<String, double> bestGpaPerCourse = {};
              if (historyState is StudentHistorySuccess) {
                for (final semester in historyState.history) {
                  for (final course in semester.courses) {
                    if (course.courseGpa != null) {
                      final current = bestGpaPerCourse[course.courseId];
                      if (current == null || course.courseGpa! > current) {
                        bestGpaPerCourse[course.courseId] = course.courseGpa!;
                      }
                    }
                  }
                }
              }

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
                    Row(
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
                              enrollment.courseCode,
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
                    ),
                    SizedBox(height: 10.w),

                    Text(
                      enrollment.courseName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Icon(
                          Icons.stars_rounded,
                          size: 16,
                          color: context.themeColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "${enrollment.creditHours} Credits",
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
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
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
                    ),

                    // prerequisites list section
                    if (hasPrerequisites) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 10.w,
                        ),
                        decoration: BoxDecoration(
                          color: context.themeColors.warningContainer,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Prerequisites:",
                              style: TextStyle(
                                color: context.themeColors.warning,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 6.w),
                            ...prerequisites.map((prereq) {
                              final double? gpa =
                                  bestGpaPerCourse[prereq.id];
                              final String name = prereq.courseNameEN.isNotEmpty
                                  ? prereq.courseNameEN
                                  : prereq.courseNameAR;

                              return Padding(
                                padding: EdgeInsets.only(bottom: 4.w),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 5.r,
                                      color: context.themeColors.warning,
                                    ),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        "${prereq.courseCode}: $name",
                                        style: TextStyle(
                                          color: context.themeColors.textSecondary,
                                          fontSize: 12.5.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: gpa != null
                                            ? context.colorScheme.surface
                                            : context.themeColors.warning
                                                  .withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(4.r),
                                      ),
                                      child: Text(
                                        gpa != null
                                            ? "GPA: $gpa"
                                            : "Not Taken",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: gpa != null
                                              ? context.themeColors.textPrimary
                                              : context.themeColors.warning,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
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