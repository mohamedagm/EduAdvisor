import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:flutter/material.dart';

class AvailableCourseModel {
  const AvailableCourseModel({
    required this.semesterCourseId,
    required this.courseId,
    required this.courseCode,
    required this.courseName,
    required this.creditHours,
    required this.isRetake,
  });

  final String semesterCourseId;
  final String courseId;
  final String courseCode;
  final String courseName;
  final int creditHours;
  final bool isRetake;

  factory AvailableCourseModel.fromJson(Map<String, dynamic> json) {
    return AvailableCourseModel(
      semesterCourseId: json['semesterCourseId'] as String? ?? '',
      courseId: json['courseId'] as String? ?? '',
      courseCode: json['courseCode'] as String? ?? '',
      courseName: json['courseName'] as String? ?? '',
      creditHours: json['creditHours'] as int? ?? 0,
      isRetake: json['isRetake'] as bool? ?? false,
    );
  }

  String get displayCode => courseCode.isNotEmpty ? courseCode : '--';
  String get displayName => courseName.isNotEmpty ? courseName : 'Course';

  IconData get icon {
    final code = courseCode.toUpperCase();

    if (code.startsWith('CS')) return Icons.computer;
    if (code.startsWith('MATH') || code.startsWith('GEN')) {
      return Icons.calculate;
    }
    if (code.startsWith('PH')) return Icons.science_outlined;
    if (code.startsWith('EE')) return Icons.electrical_services;

    return Icons.menu_book_outlined;
  }

  Color? get iconBackgroundColor {
    final code = courseCode.toUpperCase();

    if (code.startsWith('CS')) return AppColors.bluePrimary;
    if (code.startsWith('EE')) return AppColors.purplePrimary;
    if (code.startsWith('PH')) return AppColors.successGreen;

    return null;
  }

  Gradient? get iconGradient {
    final code = courseCode.toUpperCase();

    if (code.startsWith('GEN')) return AppGradients.primary;

    return null;
  }
}
