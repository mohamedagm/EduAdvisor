import 'package:edu_advisor/features/home/views/widgets/course_card.dart';
import 'package:flutter/material.dart';

class RecommendedCoursesBuilder extends StatelessWidget {
  const RecommendedCoursesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => const CourseCard(),
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemCount: 10,
      ),
    );
  }
}
