import 'dart:ui';

import 'package:edu_advisor/features/CourseCatalog/data/models/course_prerequisite_model.dart';

class CourseModel {
  const CourseModel({
    required this.id,
    required this.courseCode,
    required this.courseNameEN,
    required this.courseNameAR,
    required this.descriptionEN,
    required this.descriptionAR,
    required this.creditHours,
    required this.type,
    required this.standardLevel,
    required this.standardSemester,
    required this.isActive,
    required this.createdAt,
    this.departmentId,
    this.departmentNameEN,
    this.departmentNameAR,
    this.lastUpdatedAt,
    this.prerequisites = const [],
  });

  final String id;
  final String courseCode;
  final String courseNameEN;
  final String courseNameAR;
  final String descriptionEN;
  final String descriptionAR;
  final int creditHours;
  final String type;
  final int standardLevel;
  final int standardSemester;
  final bool isActive;
  final String createdAt;
  final String? departmentId;
  final String? departmentNameEN;
  final String? departmentNameAR;
  final String? lastUpdatedAt;
  final List<CoursePrerequisiteModel> prerequisites;

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    final prerequisitesList = (json['prerequisites'] as List? ?? [])
        .map(
          (p) => CoursePrerequisiteModel.fromJson(
            Map<String, dynamic>.from(p as Map? ?? {}),
          ),
        )
        .toList();

    return CourseModel(
      id: json['id'] as String? ?? '',
      courseCode: json['courseCode'] as String? ?? '',
      courseNameEN: json['courseNameEN'] as String? ?? '',
      courseNameAR: json['courseNameAR'] as String? ?? '',
      descriptionEN: json['descriptionEN'] as String? ?? '',
      descriptionAR: json['descriptionAR'] as String? ?? '',
      creditHours: json['creditHours'] as int? ?? 0,
      type: json['type']?.toString() ?? '',
      standardLevel: json['standardLevel'] as int? ?? 0,
      standardSemester: json['standardSemester'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] as String? ?? '',
      departmentId: json['departmentId'] as String?,
      departmentNameEN: json['departmentNameEN'] as String?,
      departmentNameAR: json['departmentNameAR'] as String?,
      lastUpdatedAt: json['lastUpdatedAt'] as String?,
      prerequisites: prerequisitesList,
    );
  }

  String get courseName => _firstNonEmpty([courseNameEN, courseNameAR], 'Course');
  String get description =>
      _firstNonEmpty([descriptionEN, descriptionAR], 'No description available');
  String get departmentName =>
      _firstNonEmpty([departmentNameEN ?? '', departmentNameAR ?? ''], 'General');

  String nameFor(Locale locale) => locale.languageCode.toLowerCase() == 'ar'
      ? _firstNonEmpty([courseNameAR, courseNameEN], 'Course')
      : courseName;

  String descriptionFor(Locale locale) =>
      locale.languageCode.toLowerCase() == 'ar'
          ? _firstNonEmpty([descriptionAR, descriptionEN], 'No description available')
          : description;

  String departmentFor(Locale locale) =>
      locale.languageCode.toLowerCase() == 'ar'
          ? _firstNonEmpty(
              [departmentNameAR ?? '', departmentNameEN ?? ''], 'General')
          : departmentName;

  static String _firstNonEmpty(List<String> candidates, String fallback) {
    for (final candidate in candidates) {
      if (candidate.trim().isNotEmpty) return candidate;
    }
    return fallback;
  }

  String get displayCode => courseCode.isNotEmpty ? courseCode : '--';
  String get displayName => courseName;
  String get displayDescription => description;
  String get displayType => type.isNotEmpty ? type : '--';
  String get displayDepartment => departmentName;
  String get displayCreditHours => creditHours.toString();
}
