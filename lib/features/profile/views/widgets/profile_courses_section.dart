import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/profile/data/models/student_course_model.dart';
import 'package:edu_advisor/features/profile/data/repo/profile_courses_repo.dart';
import 'package:edu_advisor/features/profile/manager/profile_courses_cubit/profile_courses_cubit.dart';
import 'package:edu_advisor/features/profile/manager/profile_courses_cubit/profile_courses_state.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCoursesSection extends StatefulWidget {
  const ProfileCoursesSection({super.key});

  @override
  State<ProfileCoursesSection> createState() => _ProfileCoursesSectionState();
}

class _ProfileCoursesSectionState extends State<ProfileCoursesSection>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filters = [
      context.l10n.completed,
      context.l10n.inProgress,
      context.l10n.remaining,
    ];

    return BlocProvider(
      create: (context) =>
          ProfileCoursesCubit(profileCoursesRepo: getIt<ProfileCoursesRepo>())
            ..getMyCourses(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: context.themeColors.card,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: context.themeColors.border, width: 2.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.myCourses,
                style: AppTextStyles.heading2PoppinsSb18.responsive,
              ),
              SizedBox(height: 20.w),
              TabBar(
                controller: _tabController,
                tabs: filters.map((filter) => Tab(text: filter)).toList(),
                labelStyle: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(fontSize: 13.sp),
                labelColor: AppColors.aiPink,
                unselectedLabelColor: context.themeColors.textMuted,
                indicatorColor: AppColors.aiPurple,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: context.themeColors.border,
              ),
              SizedBox(height: 16.w),
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
          (index) => Padding(
            padding: EdgeInsets.only(bottom: 12.w),
            child: const _ProfileCourseSkeletonCard(),
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
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border, width: 2.w),
      ),
      child: Column(
        children: [
          Row(
            children: [
              AppShimmerBox(width: 40.r, height: 40.r, shape: BoxShape.circle),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBox(width: 72.w, height: 16.w),
                    SizedBox(height: 6.w),
                    AppShimmerBox(height: 13.w),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              AppShimmerBox(width: 42.w, height: 16.w),
            ],
          ),
          SizedBox(height: 12.w),
          AppShimmerBox(height: 8.w, borderRadius: 10.r),
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
        padding: EdgeInsets.symmetric(vertical: 24.w),
        child: Center(
          child: Text(
            context.l10n.noProfileCourses,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: context.themeColors.textMuted,
              fontSize: 14.sp,
            ),
          ),
        ),
      );
    }

    return Column(
      children: courses
          .map(
            (course) => Padding(
              padding: EdgeInsets.only(bottom: 12.w),
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
      padding: EdgeInsets.symmetric(vertical: 24.w),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              size: 24.r,
              color: context.colorScheme.error,
            ),
            SizedBox(height: 8.w),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
            SizedBox(height: 8.w),
            TextButton(
              onPressed: context.read<ProfileCoursesCubit>().getMyCourses,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
