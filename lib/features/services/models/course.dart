import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradiants.dart';

class Course {
  final String id;
  final String name;
  final int credits;
  final List<String> prerequisites;
  final IconData icon;
  final Color? iconBackgroundColor;
  final Gradient? iconGradient;

  const Course({
    required this.id,
    required this.name,
    required this.credits,
    required this.prerequisites,
    required this.icon,
    this.iconBackgroundColor,
    this.iconGradient,
  });
}

// Mock Data
final List<Course> mockAvailableCourses = [
  const Course(
    id: 'IS312',
    name: 'Database Management System',
    credits: 3,
    prerequisites: ['CS101'],
    icon: Icons.lock,
    iconGradient: AppGradients.primary,
  ),
  const Course(
    id: 'CS201',
    name: 'Data Structures & Algorithms',
    credits: 3,
    prerequisites: [],
    icon: Icons.bar_chart,
    iconBackgroundColor: AppColors.bluePrimary,
  ),
  const Course(
    id: 'CS301',
    name: 'Machine Learning',
    credits: 3,
    prerequisites: ['MATH201', 'CS201'],
    icon: Icons.smart_toy,
    iconBackgroundColor: AppColors.purplePrimary,
  ),
  const Course(
    id: 'CS350',
    name: 'Database Systems',
    credits: 3,
    prerequisites: ['CS201'],
    icon: Icons.computer,
    iconBackgroundColor: AppColors.bluePrimary,
  ),
  const Course(
    id: 'MATH301',
    name: 'Math3',
    credits: 3,
    prerequisites: ['MATH201'],
    icon: Icons.calculate,
    iconBackgroundColor: Color(0xFFF97316),
  ),
  const Course(
    id: 'CS220',
    name: 'Computer Networks',
    credits: 3,
    prerequisites: ['CS201'],
    icon: Icons.network_cell,
    iconBackgroundColor: AppColors.bluePrimary,
  ),
  const Course(
    id: 'CS280',
    name: 'Operating Systems',
    credits: 3,
    prerequisites: ['CS201'],
    icon: Icons.language,
    iconBackgroundColor: AppColors.aiPurple,
  ),
  const Course(
    id: 'CS391',
    name: 'Software Engineering',
    credits: 3,
    prerequisites: ['CS201'],
    icon: Icons.phone_android,
    iconBackgroundColor: AppColors.purplePrimary,
  ),
];
