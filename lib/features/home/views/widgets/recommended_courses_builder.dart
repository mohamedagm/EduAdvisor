import 'package:edu_advisor/features/home/views/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedCoursesBuilder extends StatelessWidget {
  const RecommendedCoursesBuilder({super.key});

  static const List<Map<String, String>> _mockCourses = [
    {
      'imageUrl':
          'https://img.freepik.com/free-photo/learning-education-ideas-insight-intelligence-study-concept_53876-120116.jpg?semt=ais_hybrid&w=740&q=80',
      'code': 'IS 311',
      'title': 'DATABASE SYSTEMS',
      'progressPercentage': '75%',
      'credits': '3',
    },
    {
      'imageUrl':
          'https://d35v9chtr4gec.cloudfront.net/uteach/assets/feature-courses-1.webp',
      'code': 'CS 201',
      'title': 'DATA STRUCTURES',
      'progressPercentage': '90%',
      'credits': '4',
    },
    {
      'imageUrl':
          'https://images.shiksha.com/mediadata/ugcDocuments/images/wordpressImages/2020_05_software-development-i1.jpg',
      'code': 'SE 305',
      'title': 'SOFTWARE ENGINEERING',
      'progressPercentage': '60%',
      'credits': '3',
    },
    {
      'imageUrl':
          'https://www.thinkific.com/wp-content/uploads/2025/05/courses-hero.jpg',
      'code': 'AI 402',
      'title': 'MACHINE LEARNING',
      'progressPercentage': '85%',
      'credits': '3',
    },
    {
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpiCDsyqxcxUF1xfAaaauRsqkgZGb8_zy-yw&s',
      'code': 'MATH 101',
      'title': 'CALCULUS I',
      'progressPercentage': '40%',
      'credits': '3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _mockCourses.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final course = _mockCourses[index];
          return CourseCard(
            imageUrl: course['imageUrl']!,
            code: course['code']!,
            title: course['title']!,
            progressPercentage: course['progressPercentage']!,
            credits: int.parse(course['credits']!),
          );
        },
      ),
    );
  }
}
