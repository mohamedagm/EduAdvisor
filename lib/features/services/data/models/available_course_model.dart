import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:flutter/material.dart';

class AvailableCourseModel {
  const AvailableCourseModel({
    required this.semesterCourseId,
    required this.courseId,
    required this.courseNameAr,
    required this.courseNameEn,
    required this.courseCode,
    required this.level,
    required this.isOffered,
    this.semesterId,
    this.departmentId,
  });

  final String semesterCourseId;
  final String courseId;
  final String courseNameAr;
  final String courseNameEn;
  final String courseCode;
  final int level;
  final bool isOffered;
  final String? semesterId;
  final String? departmentId;

  factory AvailableCourseModel.fromJson(Map<String, dynamic> json) {
    return AvailableCourseModel(
      semesterCourseId: json['id'] as String? ?? '',
      courseId: json['courseId'] as String? ?? '',
      courseNameAr: json['courseNameAr'] as String? ?? '',
      courseNameEn: json['courseNameEn'] as String? ?? '',
      courseCode: json['courseCode'] as String? ?? '',
      level: json['level'] as int? ?? 0,
      isOffered: json['isOffered'] as bool? ?? true,
      semesterId: json['semesterId'] as String?,
      departmentId: json['departmentId'] as String?,
    );
  }

  String get courseName => _firstNonEmpty([courseNameEn, courseNameAr], 'Course');

  String nameFor(Locale locale) => locale.languageCode.toLowerCase() == 'ar'
      ? _firstNonEmpty([courseNameAr, courseNameEn], 'Course')
      : courseName;

  static String _firstNonEmpty(List<String> candidates, String fallback) {
    for (final candidate in candidates) {
      if (candidate.trim().isNotEmpty) return candidate;
    }
    return fallback;
  }

  String get displayCode => courseCode.isNotEmpty ? courseCode : '--';
  String get displayName => courseName;

  IconData get icon {
    final code = courseCode.toUpperCase();

    if (code.startsWith('CS')) return Icons.computer;
    if (code.startsWith('MATH') || code.startsWith('GEN') || code.startsWith('BS')) {
      return Icons.calculate;
    }
    if (code.startsWith('PH')) return Icons.science_outlined;
    if (code.startsWith('EE')) return Icons.electrical_services;
    if (code.startsWith('IS')) return Icons.account_tree_outlined;

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

    if (code.startsWith('GEN') || code.startsWith('BS')) return AppGradients.primary;

    return null;
  }
}
