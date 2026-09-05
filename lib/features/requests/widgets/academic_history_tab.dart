import 'package:edu_advisor/features/requests/manager/cubit/student_hestory_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';

import 'package:edu_advisor/features/requests/manager/cubit/student_history_state.dart';

class AcademicHistoryTab extends StatelessWidget {
  const AcademicHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentHistoryCubit, StudentHistoryState>(
      builder: (context, state) {
        if (state is StudentHistoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is StudentHistoryFailure) {
          return Center(
            child: Text(
              state.message,
              style: TextStyle(color: context.colorScheme.error),
            ),
          );
        }

        if (state is StudentHistorySuccess) {
          if (state.history.isEmpty) {
            return Center(
              child: Text(
                context.l10n.noAcademicHistory,
                style: TextStyle(color: context.themeColors.textMuted),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: state.history.length,
            itemBuilder: (context, index) {
              final semester = state.history[index];

              return Container(
                margin: EdgeInsets.only(bottom: 12.w),
                decoration: BoxDecoration(
                  color: context.themeColors.card,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: context.themeColors.mutedSurface),
                ),
                child: ExpansionTile(
                  shape: const Border(),
                  title: Text(
                    semester.semesterNameEn,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  subtitle: Text(
                    context.l10n.coursesEnrolled(semester.courses.length),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.themeColors.textMuted,
                    ),
                  ),
                  children: semester.courses.map((course) {
                    return Container(
                      padding: EdgeInsets.all(12.w),
                      margin: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.w,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.surface,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  course.courseCode,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.sp,
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                                SizedBox(height: 2.w),
                                Text(
                                  course.courseNameEn,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                context.l10n.creditHours(course.creditHours),
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: context.themeColors.textMuted,
                                ),
                              ),
                              if (course.courseGpa != null) ...[
                                SizedBox(height: 4.w),
                                Builder(
                                  builder: (context) {
                                    final bool isLowGpa =
                                        course.courseGpa! < 2.0;

                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isLowGpa
                                            ? context.colorScheme.errorContainer
                                            : context
                                                  .themeColors
                                                  .successContainer,
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                      child: Text(
                                        context.l10n.gpaValue(
                                          course.courseGpa.toString(),
                                        ),
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.bold,
                                          color: isLowGpa
                                              ? context.colorScheme.error
                                              : context.themeColors.success,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
