import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_course_card.dart';
import 'package:flutter/material.dart';

class ProfileCoursesSection extends StatefulWidget {
  const ProfileCoursesSection({super.key});

  @override
  State<ProfileCoursesSection> createState() => _ProfileCoursesSectionState();
}

class _ProfileCoursesSectionState extends State<ProfileCoursesSection>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<String> _filters = ['Completed', 'In Progress', 'Remaining'];

  final List<Map<String, dynamic>> _courses = [
    {
      'code': 'CS350',
      'name': 'Database Systems',
      'progress': 0.75,
      'credits': 3,
    },
    {
      'code': 'CS301',
      'name': 'Machine Learning',
      'progress': 0.60,
      'credits': 3,
    },
    {
      'code': 'CS410',
      'name': 'Software Engineering',
      'progress': 0.40,
      'credits': 3,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _filters.length,
      vsync: this,
      initialIndex: 1,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _getCoursesForTab(int index) {
    switch (index) {
      case 0: // Completed
        return _courses.where((c) => (c['progress'] as double) >= 1.0).toList();
      case 1: // In Progress
        return _courses.where((c) {
          final p = c['progress'] as double;
          return p > 0.0 && p < 1.0;
        }).toList();
      case 2: // Remaining
        return _courses.where((c) => (c['progress'] as double) == 0.0).toList();
      default:
        return _courses;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            AnimatedBuilder(
              animation: _tabController,
              builder: (context, _) {
                final courses = _getCoursesForTab(_tabController.index);
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
                          child: ProfileCourseCard(
                            code: course['code'],
                            name: course['name'],
                            progress: course['progress'],
                            credits: course['credits'],
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
