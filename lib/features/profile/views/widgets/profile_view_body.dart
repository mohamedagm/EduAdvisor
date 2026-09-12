import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_courses_section.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_graduation_progress_card.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_header.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_registration_status_card.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_stats_row.dart';
import 'package:edu_advisor/features/services/data/repo/course_registration_repo.dart';
import 'package:edu_advisor/features/services/manager/registration_status_cubit/registration_status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegistrationStatusCubit(repo: getIt<CourseRegistrationRepo>())
            ..getRegistrationRequests(),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const ProfileHeader(),
                  Positioned(
                    bottom: -100.w,
                    left: 16.w,
                    right: 16.w,
                    child: SizedBox(
                      height: 120.w,
                      child: const ProfileStatsRow(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 120.w),
              const ProfileRegistrationStatusCard(),
              SizedBox(height: 16.w),
              const ProfileGraduationProgressCard(),
              SizedBox(height: 24.w),
              const ProfileCoursesSection(),
              SizedBox(height: 24.w),
            ],
          ),
        ),
      ),
    );
  }
}
