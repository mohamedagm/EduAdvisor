import 'package:flutter/material.dart';

class MyStudentModel {
  const MyStudentModel({
    required this.id,
    required this.userId,
    required this.fullNameAR,
    required this.fullNameEN,
    required this.studentCode,
    required this.academicYear,
    required this.completedHours,
    required this.overAllGPA,
    required this.remainingHours,
    this.createdAt,
    this.lastUpdatedAt,
  });

  final String id;
  final String userId;
  final String fullNameAR;
  final String fullNameEN;
  final String studentCode;
  final int academicYear;
  final int completedHours;
  final double overAllGPA;
  final int remainingHours;
  final String? createdAt;
  final String? lastUpdatedAt;

  factory MyStudentModel.fromJson(Map<String, dynamic> json) {
    return MyStudentModel(
      id: json['id'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      fullNameAR: json['fullNameAR'] as String? ?? '',
      fullNameEN: json['fullNameENG'] as String? ?? '',
      studentCode: json['studentCode'] as String? ?? '',
      academicYear: json['academicYear'] as int? ?? 1,
      completedHours: json['completedHours'] as int? ?? 0,
      overAllGPA: (json['overAllGPA'] as num?)?.toDouble() ?? 0.0,
      remainingHours: json['remainingHours'] as int? ?? 0,
      createdAt: json['createdAt'] as String?,
      lastUpdatedAt: json['lastUpdatedAt'] as String?,
    );
  }

  String nameFor(Locale locale) =>
      locale.languageCode == 'ar' ? fullNameAR : fullNameEN;
}
