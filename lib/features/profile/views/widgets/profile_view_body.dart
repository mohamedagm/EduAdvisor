import 'package:edu_advisor/features/profile/views/widgets/profile_courses_section.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_graduation_progress_card.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_header.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_stats_row.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ProfileHeader(),
                Positioned(
                  bottom: -100,
                  left: 16,
                  right: 16,
                  child: SizedBox(height: 120, child: ProfileStatsRow()),
                ),
              ],
            ),
            SizedBox(height: 120),
            ProfileGraduationProgressCard(),
            SizedBox(height: 24),
            ProfileCoursesSection(),
          ],
        ),
      ),
    );
  }
}
