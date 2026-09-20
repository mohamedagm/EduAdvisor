import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/features/requests/manager/cubit/available_courses_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/available_courses_state.dart';
import 'package:edu_advisor/features/requests/models/available_courses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableCoursesTab extends StatelessWidget {
  const AvailableCoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvailableCoursesCubit, AvailableCoursesState>(
      builder: (context, state) {
        if (state is AvailableCoursesLoading ||
            state is AvailableCoursesInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AvailableCoursesFailure) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: context.colorScheme.error),
            ),
          );
        }

        if (state is AvailableCoursesSuccess) {
          final courses = state.data.availableCourses;

          if (courses.isEmpty) {
            return Center(
              child: Text(
                context.l10n.noAvailableCourses,
                style: TextStyle(color: context.themeColors.textMuted),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: courses.length,
            itemBuilder: (context, index) =>
                _AvailableCourseCard(course: courses[index]),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _AvailableCourseCard extends StatelessWidget {
  const _AvailableCourseCard({required this.course});

  final AvailableCourseModel course;

  String _typeLabel(BuildContext context) {
    switch (course.courseType) {
      case 'Required':
        return context.l10n.requiredLabel;
      case 'DepartmentRequired':
        return context.l10n.departmentRequiredLabel;
      case 'DepartmentElective':
        return context.l10n.departmentElectiveLabel;
      default:
        return course.courseType;
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = course.displayCourseName(Localizations.localeOf(context));

    return Container(
      margin: EdgeInsets.only(bottom: 10.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.themeColors.mutedSurface),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.courseCode,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary,
                  ),
                ),
                SizedBox(height: 2.w),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.themeColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.w),
                Text(
                  "${course.creditHours} ${context.l10n.creditHoursLabel}",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: context.themeColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.w),
                decoration: BoxDecoration(
                  color: context.themeColors.mutedSurface,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  _typeLabel(context),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: context.themeColors.textSecondary,
                  ),
                ),
              ),
              if (course.isRepeated) ...[
                SizedBox(height: 6.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 7.w,
                    vertical: 3.w,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.error.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    context.l10n.attemptLabel(course.attemptCount ),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      // color: context.colorScheme.error,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}