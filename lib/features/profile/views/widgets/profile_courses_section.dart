import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/profile/data/models/student_course_model.dart';
import 'package:edu_advisor/features/profile/data/repo/profile_courses_repo.dart';
import 'package:edu_advisor/features/profile/manager/profile_courses_cubit/profile_courses_cubit.dart';
import 'package:edu_advisor/features/profile/manager/profile_courses_cubit/profile_courses_state.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCoursesSection extends StatefulWidget {
  const ProfileCoursesSection({super.key});

  @override
  State<ProfileCoursesSection> createState() => _ProfileCoursesSectionState();
}

class _ProfileCoursesSectionState extends State<ProfileCoursesSection>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> _filters = ['Completed', 'In Progress', 'Remaining'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _filters.length,
      vsync: this,
      initialIndex: 2,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCoursesCubit(
        profileCoursesRepo: ProfileCoursesRepo(apiConsumer: DioConsumer()),
      )..getMyCourses(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.gray200, width: 2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Courses', style: AppTextStyles.heading2PoppinsSb18),
              const SizedBox(height: 20),
              TabBar(
                controller: _tabController,
                tabs: _filters.map((f) => Tab(text: f)).toList(),
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(fontSize: 13),
                labelColor: AppColors.aiPink,
                unselectedLabelColor: AppColors.gray400,
                indicatorColor: AppColors.aiPurple,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: AppColors.gray200,
              ),
              const SizedBox(height: 16),
              BlocBuilder<ProfileCoursesCubit, ProfileCoursesState>(
                builder: (context, state) {
                  if (state is ProfileCoursesLoading ||
                      state is ProfileCoursesInitial) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (state is ProfileCoursesFailure) {
                    return _ProfileCoursesError(message: state.failure.message);
                  }

                  if (state is ProfileCoursesLoaded) {
                    return AnimatedBuilder(
                      animation: _tabController,
                      builder: (context, _) {
                        final courses = state.coursesForTab(
                          _tabController.index,
                        );
                        return _ProfileCoursesList(courses: courses);
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileCoursesList extends StatelessWidget {
  const _ProfileCoursesList({required this.courses});

  final List<StudentCourseModel> courses;

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            'No courses here yet.',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      children: courses
          .map(
            (course) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProfileCourseCard(course: course),
            ),
          )
          .toList(),
    );
  }
}

class _ProfileCoursesError extends StatelessWidget {
  const _ProfileCoursesError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.error_outline, color: AppColors.errorRed),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: AppColors.gray600,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: context.read<ProfileCoursesCubit>().getMyCourses,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
