import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_gradiants.dart';
import '../../../core/widgets/app_toast.dart';
import '../data/models/available_course_model.dart';
import '../data/repo/course_registration_repo.dart';
import '../manager/course_registration_cubit/course_registration_cubit.dart';
import '../manager/course_registration_cubit/course_registration_state.dart';
import 'widgets/course_status_card.dart';
import 'widgets/empty_courses_card.dart';
import 'widgets/selected_course_item.dart';
import 'widgets/available_courses_sheet.dart';
import 'widgets/service_app_bar.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class CourseRegistrationView extends StatefulWidget {
  const CourseRegistrationView({super.key});

  @override
  State<CourseRegistrationView> createState() => _CourseRegistrationViewState();
}

class _CourseRegistrationViewState extends State<CourseRegistrationView> {
  final List<AvailableCourseModel> _selectedCourses = [];
  final int _maxCredits = 18;
  final int _minCredits = 12;
  late final CourseRegistrationCubit _courseRegistrationCubit;

  int get _currentCredits =>
      _selectedCourses.fold(0, (sum, course) => sum + course.creditHours);

  @override
  void initState() {
    super.initState();
    _courseRegistrationCubit = CourseRegistrationCubit(
      repo: CourseRegistrationRepo(apiConsumer: DioConsumer()),
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
                                  c.semesterCourseId == course.semesterCourseId,
                            );
                          });
                          setModalState(() {});
                        } else {
                          if (_currentCredits + course.creditHours <=
                              _maxCredits) {
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
    final bool canSubmit =
        _currentCredits >= _minCredits && _currentCredits <= _maxCredits;

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
            context.pop();
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

          return Scaffold(
            appBar: ServiceAppBar(
              title: context.l10n.courseRegistrationTitle,
              subtitle: context.l10n.spring2024Semester,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CourseStatusCard(
                    currentCredits: _currentCredits,
                    minCredits: _minCredits,
                    maxCredits: _maxCredits,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.selectedCoursesCount(
                          _selectedCourses.length,
                        ),
                        style: AppTextStyles.interRegular16.copyWith(
                          color: context.themeColors.textPrimary,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: isSubmitting ? null : _showAvailableCourses,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.themeColors.info,
                          foregroundColor: context.themeColors.onInfo,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.add, size: 16),
                        label: Text(
                          context.l10n.addCourse,
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: context.themeColors.onInfo,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (_selectedCourses.isEmpty)
                    const EmptyCoursesCard()
                  else ...[
                    for (final course in _selectedCourses)
                      SelectedCourseItem(
                        course: course,
                        onRemove: () => _removeCourse(course),
                      ),
                    const SizedBox(height: 24),
                    Opacity(
                      opacity: canSubmit && !isSubmitting ? 1.0 : 0.5,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          gradient: AppGradients.primary,
                        ),
                        child: ElevatedButton(
                          onPressed: canSubmit && !isSubmitting
                              ? _submitRegistrationRequest
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            disabledBackgroundColor: Colors.transparent,
                            disabledForegroundColor: AppColors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isSubmitting)
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.white,
                                  ),
                                )
                              else
                                const Icon(
                                  Icons.send_outlined,
                                  color: AppColors.white,
                                  size: 20,
                                ),
                              const SizedBox(width: 8),
                              Text(
                                isSubmitting
                                    ? context.l10n.submitting
                                    : context.l10n.submitForApproval,
                                style: AppTextStyles.buttonsText.copyWith(
                                  color: AppColors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
