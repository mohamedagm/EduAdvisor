import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/services/data/models/available_course_model.dart';
import 'package:edu_advisor/features/services/data/repo/course_registration_repo.dart';
import 'package:edu_advisor/features/services/manager/course_registration_cubit/course_registration_cubit.dart';
import 'package:edu_advisor/features/services/manager/course_registration_cubit/course_registration_state.dart';
import 'package:edu_advisor/features/services/views/widgets/available_courses_sheet.dart';
import 'package:edu_advisor/features/services/views/widgets/empty_courses_card.dart';
import 'package:edu_advisor/features/services/views/widgets/selected_course_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CourseRegistrationTool extends StatefulWidget {
  const CourseRegistrationTool({super.key, this.isTab = false});

  final bool isTab;

  @override
  State<CourseRegistrationTool> createState() => _CourseRegistrationToolState();
}

class _CourseRegistrationToolState extends State<CourseRegistrationTool> {
  final List<AvailableCourseModel> _selectedCourses = [];
  final int _maxCourses = 10;
  late final CourseRegistrationCubit _courseRegistrationCubit;

  @override
  void initState() {
    super.initState();
    _courseRegistrationCubit = CourseRegistrationCubit(
      repo: getIt<CourseRegistrationRepo>(),
    );
  }

  @override
  void dispose() {
    _courseRegistrationCubit.close();
    super.dispose();
  }

  void _showAvailableCourses() {
    _courseRegistrationCubit.getAvailableCourses();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return SizedBox(
          height: MediaQuery.of(bottomSheetContext).size.height * 0.8,
          child: ScaffoldMessenger(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: StatefulBuilder(
                builder: (context, setModalState) {
                  return BlocProvider.value(
                    value: _courseRegistrationCubit,
                    child: AvailableCoursesSheet(
                      selectedCourseIds: _selectedCourses
                          .map((e) => e.semesterCourseId)
                          .toSet(),
                      onCourseToggled: (course) {
                        final isSelected = _selectedCourses.any(
                          (c) => c.semesterCourseId == course.semesterCourseId,
                        );
                        if (isSelected) {
                          setState(() {
                            _selectedCourses.removeWhere(
                              (c) =>
                                  c.semesterCourseId ==
                                  course.semesterCourseId,
                            );
                          });
                          setModalState(() {});
                        } else {
                          if (_selectedCourses.length < _maxCourses) {
                            setState(() {
                              _selectedCourses.add(course);
                            });
                            setModalState(() {});
                          } else {
                            AppToast.warning(
                              context,
                              title: context.l10n.creditLimitReached,
                              description:
                                  context.l10n.creditLimitReachedDescription,
                            );
                          }
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _removeCourse(AvailableCourseModel course) {
    setState(() {
      _selectedCourses.removeWhere(
        (c) => c.semesterCourseId == course.semesterCourseId,
      );
    });
  }

  void _submitRegistrationRequest() {
    final semesterCourseIds = _selectedCourses
        .map((course) => course.semesterCourseId)
        .toList();

    _courseRegistrationCubit.submitRegistrationRequest(semesterCourseIds);
  }

  @override
  Widget build(BuildContext context) {
    final bool canSubmit = _selectedCourses.isNotEmpty;

    return BlocProvider.value(
      value: _courseRegistrationCubit,
      child: BlocConsumer<CourseRegistrationCubit, CourseRegistrationState>(
        listener: (context, state) {
          if (state is SubmitRegistrationSuccess) {
            AppToast.success(
              context,
              title: context.l10n.registrationSubmitted,
              description: state.response.message,
            );
            if (widget.isTab) {
              setState(() => _selectedCourses.clear());
            } else {
              context.pop();
            }
          }

          if (state is SubmitRegistrationFailure) {
            AppToast.error(
              context,
              title: context.l10n.submissionFailed,
              description: state.failure.message,
            );
          }
        },
        builder: (context, state) {
          final isSubmitting = state is SubmitRegistrationLoading;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.selectedCoursesCount(
                        _selectedCourses.length,
                      ),
                      style: AppTextStyles.interRegular16.responsive.copyWith(
                        color: context.themeColors.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  ElevatedButton.icon(
                    onPressed: isSubmitting ? null : _showAvailableCourses,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.themeColors.info,
                      foregroundColor: context.themeColors.onInfo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.w,
                      ),
                      elevation: 0,
                    ),
                    icon: Icon(Icons.add, size: 16.r),
                    label: Text(
                      context.l10n.addCourse,
                      style: AppTextStyles.bodyInterRegular12.responsive
                          .copyWith(
                            color: context.themeColors.onInfo,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.w),
              if (_selectedCourses.isEmpty)
                const EmptyCoursesCard()
              else ...[
                for (final course in _selectedCourses)
                  SelectedCourseItem(
                    course: course,
                    onRemove: () => _removeCourse(course),
                  ),
                SizedBox(height: 24.w),
                Opacity(
                  opacity: canSubmit && !isSubmitting ? 1.0 : 0.5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      gradient: AppGradients.primary,
                    ),
                    child: ElevatedButton(
                      onPressed: canSubmit && !isSubmitting
                          ? _submitRegistrationRequest
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        disabledBackgroundColor: Colors.transparent,
                        disabledForegroundColor: AppColors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isSubmitting)
                            SizedBox(
                              width: 20.r,
                              height: 20.r,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.w,
                                color: AppColors.white,
                              ),
                            )
                          else
                            Icon(
                              Icons.send_outlined,
                              color: AppColors.white,
                              size: 20.r,
                            ),
                          SizedBox(width: 8.w),
                          Text(
                            isSubmitting
                                ? context.l10n.submitting
                                : context.l10n.submitForApproval,
                            style: AppTextStyles.buttonsText.copyWith(
                              color: AppColors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}