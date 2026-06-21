import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/profile/data/models/student_course_model.dart';
import 'package:edu_advisor/features/profile/data/repo/profile_courses_repo.dart';
import 'package:edu_advisor/features/profile/manager/profile_courses_cubit/profile_courses_cubit.dart';
import 'package:edu_advisor/features/profile/manager/profile_courses_cubit/profile_courses_state.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

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
            color: context.themeColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: context.themeColors.border, width: 2),
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
                unselectedLabelColor: context.themeColors.textMuted,
                indicatorColor: AppColors.aiPurple,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: context.themeColors.border,
              ),
              const SizedBox(height: 16),
              BlocBuilder<ProfileCoursesCubit, ProfileCoursesState>(
                builder: (context, state) {
                  if (state is ProfileCoursesLoading ||
                      state is ProfileCoursesInitial) {
                    return const _ProfileCoursesShimmer();
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

class _ProfileCoursesShimmer extends StatelessWidget {
  const _ProfileCoursesShimmer();

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: List.generate(
          3,
          (index) => const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: _ProfileCourseSkeletonCard(),
          ),
        ),
      ),
    );
  }
}

class _ProfileCourseSkeletonCard extends StatelessWidget {
  const _ProfileCourseSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.themeColors.border, width: 2),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              AppShimmerBox(width: 40, height: 40, shape: BoxShape.circle),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBox(width: 72, height: 16),
                    SizedBox(height: 6),
                    AppShimmerBox(height: 13),
                  ],
                ),
              ),
              SizedBox(width: 16),
              AppShimmerBox(width: 42, height: 16),
            ],
          ),
          SizedBox(height: 12),
          AppShimmerBox(height: 8, borderRadius: 10),
        ],
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
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            'No courses here yet.',
            style: TextStyle(color: context.themeColors.textMuted),
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
            Icon(Icons.error_outline, color: context.colorScheme.error),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: context.themeColors.textSecondary,
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
