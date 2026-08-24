import 'package:flutter/material.dart';

class StudentEnrollmentModel {
  const StudentEnrollmentModel({
    required this.enrollmentId,
    required this.courseId,
    required this.courseNameAr,
    required this.courseNameEn,
    required this.creditHours,
    required this.status,
    this.coursePercentage,
    this.courseGpa,
    required this.result,
  });

  final String enrollmentId;
  final String courseId;
  final String courseNameAr;
  final String courseNameEn;
  final int creditHours;
  final int status;
  final num? coursePercentage;
  final num? courseGpa;
  final int result;

  factory StudentEnrollmentModel.fromJson(Map<String, dynamic> json) {
    return StudentEnrollmentModel(
      enrollmentId: json['enrollmentId'] as String? ?? '',
      courseId: json['courseId'] as String? ?? '',
      courseNameAr: json['courseNameAr'] as String? ?? '',
      courseNameEn: json['courseNameEn'] as String? ?? '',
      creditHours: json['creditHours'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
      coursePercentage: json['coursePercentage'] as num?,
      courseGpa: json['courseGpa'] as num?,
      result: json['result'] as int? ?? 0,
    );
  }

  String nameFor(Locale locale) =>
      locale.languageCode.toLowerCase() == 'ar'
      ? (courseNameAr.isNotEmpty ? courseNameAr : courseNameEn)
      : (courseNameEn.isNotEmpty ? courseNameEn : courseNameAr);

  bool get hasGrade => courseGpa != null;

  double? get progressValue => coursePercentage == null
      ? null
      : (coursePercentage!.toDouble() / 100).clamp(0.0, 1.0);
}
