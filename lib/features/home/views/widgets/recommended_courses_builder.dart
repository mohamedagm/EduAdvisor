import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/features/home/data/models/recommended_course_model.dart';
import 'package:edu_advisor/features/home/views/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RecommendedCoursesBuilder extends StatelessWidget {
  const RecommendedCoursesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: recommendedCourses.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final course = recommendedCourses[index];
          return InkWell(
            onTap: () => context.push(
              AppRoutes.recommendedCoursesList,
              extra: index,
            ),
            borderRadius: BorderRadius.circular(16.r),
            child: CourseCard(
              code: course.code,
              title: course.title,
              progressPercentage: course.progressPercentage,
              credits: course.credits,
            ),
          );
        },
      ),
    );
  }
}
