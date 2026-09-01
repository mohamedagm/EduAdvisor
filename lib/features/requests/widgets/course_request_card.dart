import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/features/requests/manager/cubit/prerequisites_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/prerequisites_state.dart';
import 'package:edu_advisor/features/requests/models/prerequisite_model.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseRequestCard extends StatelessWidget {
  final EnrollmentModel enrollment;

  const CourseRequestCard({
    super.key,
    required this.enrollment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PrerequisitesCubit>()
        ..fetchCoursePrerequisites(enrollment.semesterCourseId),
      child: BlocBuilder<PrerequisitesCubit, PrerequisitesState>(
        builder: (context, state) {
          String? missingPrereq;

          // 👈 ربط الداتا من PrerequisiteCourseModel
          if (state is PrerequisitesSuccessState && state.prerequisites.isNotEmpty) {
            final PrerequisiteCourseModel firstPrereq = state.prerequisites.first;
            
            // قراءة كود المادة واسمها الإنجليزي من الموديل
            final String name = firstPrereq.courseNameEN.isNotEmpty 
                ? firstPrereq.courseNameEN 
                : firstPrereq.courseNameAR;
                
            missingPrereq = "${firstPrereq.courseCode}: $name";
          }

          final bool hasWarning = missingPrereq != null;

          return Container(
            margin: EdgeInsets.only(bottom: 12.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: hasWarning
                  ? context.themeColors.warningContainer
                  : context.themeColors.card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: hasWarning
                    ? context.themeColors.warning.withValues(alpha: 0.35)
                    : context.themeColors.mutedSurface,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. كود المادة
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

                // 2. اسم المادة
                Text(
                  enrollment.courseName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
                ),
                const SizedBox(height: 12),

                // 3. الساعات + تحذير المتطلب
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

                    if (state is PrerequisitesLoadingState) ...[
                      SizedBox(width: 16.w),
                      SizedBox(
                        width: 12.r,
                        height: 12.r,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ] else if (hasWarning) ...[
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.warning_amber_rounded,
                        color: context.themeColors.warning,
                        size: 16,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "Prereqs Missing",
                        style: TextStyle(
                          color: context.themeColors.warning,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),

                // 4. الشريط السفلي الأصفر للمادة المفقودة
                if (hasWarning) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
                    decoration: BoxDecoration(
                      color: context.themeColors.warningContainer,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: context.themeColors.warning,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Missing: $missingPrereq",
                            style: TextStyle(
                              color: context.themeColors.warning,
                              fontWeight: FontWeight.w600,
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}