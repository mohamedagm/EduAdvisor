import 'dart:ui';

class AvailableCourseModel {
  final String semesterCourseId;
  final String courseCode;
  final String courseNameEn;
  final String courseNameAr;
  final String courseType;
  final int creditHours;
  final String departmentId;
  final int attemptCount;

  AvailableCourseModel({
    required this.semesterCourseId,
    required this.courseCode,
    required this.courseNameEn,
    required this.courseNameAr,
    required this.courseType,
    required this.creditHours,
    required this.departmentId,
    required this.attemptCount,
  });

  factory AvailableCourseModel.fromJson(Map<String, dynamic> json) {
    return AvailableCourseModel(
      semesterCourseId: json['semesterCourseId']?.toString() ?? '',
      courseCode: json['courseCode']?.toString() ?? '',
      courseNameEn: json['courseNameEn']?.toString() ?? '',
      courseNameAr: json['courseNameAr']?.toString() ?? '',
      courseType: json['courseType']?.toString() ?? '',
      creditHours: json['creditHours'] is int
          ? json['creditHours']
          : int.tryParse('${json['creditHours']}') ?? 0,
      departmentId: json['departmentId']?.toString() ?? '',
      attemptCount: json['attemptCount'] is int
          ? json['attemptCount']
          : int.tryParse('${json['attemptCount']}') ?? 0,
    );
  }

  bool get isRepeated => attemptCount >= 2;

  String displayCourseName(Locale locale) {
    return locale.languageCode.toLowerCase() == 'ar'
        ? (courseNameAr.isNotEmpty ? courseNameAr : courseNameEn)
        : (courseNameEn.isNotEmpty ? courseNameEn : courseNameAr);
  }
}

class StudentAvailableCoursesModel {
  final int maxHours;
  final int minHours;
  final List<AvailableCourseModel> availableCourses;

  StudentAvailableCoursesModel({
    required this.maxHours,
    required this.minHours,
    required this.availableCourses,
  });

  factory StudentAvailableCoursesModel.fromJson(Map<String, dynamic> json) {
    return StudentAvailableCoursesModel(
      maxHours: json['maxHours'] is int
          ? json['maxHours']
          : int.tryParse('${json['maxHours']}') ?? 0,
      minHours: json['minHours'] is int
          ? json['minHours']
          : int.tryParse('${json['minHours']}') ?? 0,
      availableCourses:
          (json['availableCourses'] as List<dynamic>?)
              ?.map(
                (e) => AvailableCourseModel.fromJson(
                  Map<String, dynamic>.from(e),
                ),
              )
              .toList() ??
          [],
    );
  }

  factory StudentAvailableCoursesModel.empty() {
    return StudentAvailableCoursesModel(
      maxHours: 0,
      minHours: 0,
      availableCourses: const [],
    );
  }
}