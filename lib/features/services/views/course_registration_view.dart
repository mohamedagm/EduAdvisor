import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/api/dio_consumer.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_gradiants.dart';
import '../data/models/available_course_model.dart';
import '../data/repo/course_registration_repo.dart';
import '../manager/course_registration_cubit/course_registration_cubit.dart';
import 'widgets/course_status_card.dart';
import 'widgets/empty_courses_card.dart';
import 'widgets/selected_course_item.dart';
import 'widgets/available_courses_sheet.dart';
import 'widgets/service_app_bar.dart';

class CourseRegistrationView extends StatefulWidget {
  const CourseRegistrationView({super.key});

  @override
  State<CourseRegistrationView> createState() => _CourseRegistrationViewState();
}

class _CourseRegistrationViewState extends State<CourseRegistrationView> {
  final List<AvailableCourseModel> _selectedCourses = [];
  final int _maxCredits = 18;
  final int _minCredits = 12;

  int get _currentCredits =>
      _selectedCourses.fold(0, (sum, course) => sum + course.creditHours);

  void _showAvailableCourses() {
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
                  return BlocProvider(
                    create: (context) => CourseRegistrationCubit(
                      repo: CourseRegistrationRepo(apiConsumer: DioConsumer()),
                    )..getAvailableCourses(),
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Cannot exceed maximum credit limit.',
                                ),
                                backgroundColor: AppColors.errorRed,
                                behavior: SnackBarBehavior.floating,
                              ),
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

  @override
  Widget build(BuildContext context) {
    final bool canSubmit =
        _currentCredits >= _minCredits && _currentCredits <= _maxCredits;

    return Scaffold(
      appBar: const ServiceAppBar(
        title: 'Course Registration',
        subtitle: 'Spring 2024 Semester',
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
                  'Selected Courses (${_selectedCourses.length})',
                  style: AppTextStyles.interRegular16.copyWith(
                    color: AppColors.gray900,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _showAvailableCourses,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.infoBlue,
                    foregroundColor: AppColors.white,
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
                    'Add Course',
                    style: AppTextStyles.bodyInterRegular12.copyWith(
                      color: AppColors.white,
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
                opacity: canSubmit ? 1.0 : 0.5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: AppGradients.primary,
                  ),
                  child: ElevatedButton(
                    onPressed: canSubmit
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Submitted for approval!'),
                                backgroundColor: AppColors.successGreen,
                              ),
                            );
                            context.pop();
                          }
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
                        const Icon(
                          Icons.send_outlined,
                          color: AppColors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Submit for Approval',
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
  }
}
