import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/features/requests/manager/cubit/academic_record_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/academic_record_state.dart';
import 'package:edu_advisor/features/requests/manager/cubit/available_courses_cubit.dart';
import 'package:edu_advisor/features/requests/manager/cubit/available_courses_state.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/widgets/hours_range_bar.dart';
import 'package:edu_advisor/features/requests/widgets/request_stat_card.dart';
import 'package:edu_advisor/features/requests/widgets/request_student_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestStudentCard extends StatelessWidget {
  const RequestStudentCard({super.key, required this.request});

  final StudentRequest request;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcademicRecordCubit, AcademicRecordState>(
      builder: (context, academicState) {
        // Loading with Shimmer
        if (academicState is AcademicRecordLoadingState) {
          return const RequestStudentCardSkeleton();
        }

        if (academicState is AcademicRecordErrorState) {
          return Container(
            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: context.themeColors.card,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: context.colorScheme.error.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              academicState.message,
              style: TextStyle(
                color: context.colorScheme.error,
                fontSize: 13.sp,
              ),
            ),
          );
        }

        // Success
        if (academicState is AcademicRecordSuccessState) {
          final record = academicState.record;
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';
          final studentName = isArabic ? record.fullNameAr : record.fullNameEn;

          return Container(
            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: context.themeColors.card,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: context.themeColors.mutedSurface),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Student Information
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: context.themeColors.mutedSurface,
                      child: Icon(
                        Icons.person,
                        color: context.themeColors.textMuted,
                        size: 26.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            studentName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: context.themeColors.textPrimary,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.w),
                          Text(
                            '${record.studentCode} • Level ${record.currentLevel}',
                            style: TextStyle(
                              color: context.themeColors.textMuted,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _RequestStatusChip(
                      statusName: request.statusName,
                      status: request.status,
                    ),
                  ],
                ),

                SizedBox(height: 16.w),

                // GPA & Credit Hours
                Row(
                  children: [
                    RequestStatCard(
                      icon: Icons.auto_graph_rounded,
                      value: record.cumulativeGpa.toStringAsFixed(2),
                      label: 'GPA',
                    ),
                    SizedBox(width: 12.w),
                    RequestStatCard(
                      icon: Icons.stars_rounded,
                      value: record.totalCompletedHours.toString(),
                      label: context.l10n.creditHoursLabel,
                    ),
                  ],
                ),

                BlocBuilder<AvailableCoursesCubit, AvailableCoursesState>(
                  builder: (context, hoursState) {
                    int? minHours;
                    int? maxHours;
                    if (hoursState is AvailableCoursesSuccess) {
                      minHours = hoursState.data.minHours;
                      maxHours = hoursState.data.maxHours;
                    }

                    final bool hasRange =
                        minHours != null &&
                        maxHours != null &&
                        (minHours > 0 || maxHours > 0);

                    final bool withinRange =
                        hasRange &&
                        request.totalCreditHours >= minHours &&
                        request.totalCreditHours <= maxHours;

                    if (!hasRange) return const SizedBox.shrink();

                    return Column(
                      children: [
                        SizedBox(height: 8.w),
                        HoursRangeBar(
                          withinRange: withinRange,
                          minHours: minHours,
                          maxHours: maxHours,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _RequestStatusChip extends StatelessWidget {
  const _RequestStatusChip({required this.statusName, required this.status});

  final String statusName;
  final int status;

  Color _colorFor(BuildContext context) {
    switch (status) {
      case 2:
        return context.themeColors.success;
      case 3:
        return context.colorScheme.error;
      case 1:
      default:
        return context.themeColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        statusName,
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
