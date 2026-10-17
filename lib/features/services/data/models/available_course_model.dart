import 'package:flutter/material.dart';

class AvailableCourseModel {
  const AvailableCourseModel({
    required this.semesterCourseId,
    required this.courseCode,
    required this.courseNameAr,
    required this.courseNameEn,
    required this.courseType,
    required this.creditHours,
    required this.attemptCount,
    required this.departmentId,
  });

  final String semesterCourseId;
  final String courseCode;
  final String courseNameAr;
  final String courseNameEn;
  final String courseType;
  final int creditHours;
  final int attemptCount;
  final String departmentId;

  factory AvailableCourseModel.fromJson(Map<String, dynamic> json) {
    return AvailableCourseModel(
      semesterCourseId: json['semesterCourseId']?.toString() ?? '',
      courseCode: json['courseCode']?.toString() ?? '',
      courseNameAr: json['courseNameAr']?.toString() ?? '',
      courseNameEn: json['courseNameEn']?.toString() ?? '',
      courseType: json['courseType']?.toString() ?? '',
      creditHours: json['creditHours'] is int
          ? json['creditHours'] as int
          : int.tryParse('${json['creditHours']}') ?? 0,
      attemptCount: json['attemptCount'] is int
          ? json['attemptCount'] as int
          : int.tryParse('${json['attemptCount']}') ?? 0,
      departmentId: json['departmentId']?.toString() ?? '',
    );
  }

  String nameFor(Locale locale) =>
      locale.languageCode.toLowerCase() == 'ar'
          ? (courseNameAr.isNotEmpty ? courseNameAr : courseNameEn)
          : (courseNameEn.isNotEmpty ? courseNameEn : courseNameAr);

  String get typeLabel {
    return switch (courseType) {
      'Required' => 'Required',
      'DepartmentRequired' => 'Department Required',
      'DepartmentElective' => 'Department Elective',
      'Elective' => 'Elective',
      _ => courseType.isEmpty ? 'Other' : courseType,
    };
  }

  Color get typeColor => Colors.grey;
}
