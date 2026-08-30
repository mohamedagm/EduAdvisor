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
  final int courseType;
  final int creditHours;
  final int attemptCount;
  final String departmentId;

  factory AvailableCourseModel.fromJson(Map<String, dynamic> json) {
    return AvailableCourseModel(
      semesterCourseId: json['semesterCourseId'] as String? ?? '',
      courseCode: json['courseCode'] as String? ?? '',
      courseNameAr: json['courseNameAr'] as String? ?? '',
      courseNameEn: json['courseNameEn'] as String? ?? '',
      courseType: json['courseType'] as int? ?? 0,
      creditHours: json['creditHours'] as int? ?? 0,
      attemptCount: json['attemptCount'] as int? ?? 0,
      departmentId: json['departmentId'] as String? ?? '',
    );
  }

  String nameFor(Locale locale) =>
      locale.languageCode.toLowerCase() == 'ar'
          ? (courseNameAr.isNotEmpty ? courseNameAr : courseNameEn)
          : (courseNameEn.isNotEmpty ? courseNameEn : courseNameAr);

  // Helper for Course Type
  String get typeLabel {
    return switch (courseType) {
      1 => "University Req", // حسب الـ IDs اللي عندك
      2 => "Faculty Req",
      4 => "Department Req",
      5 => "Elective",
      _ => "Other",
    };
  }

  Color get typeColor {
    return switch (courseType) {
      1 => Colors.blue,
      2 => Colors.green,
      4 => Colors.purple,
      5 => Colors.orange,
      _ => Colors.grey,
    };
  }
}
