import 'package:edu_advisor/features/services/data/models/available_course_model.dart';

class AvailableCoursesResponseModel {
  const AvailableCoursesResponseModel({
    required this.minHours,
    required this.maxHours,
    required this.courses,
  });

  final int minHours;
  final int maxHours;
  final List<AvailableCourseModel> courses;

  factory AvailableCoursesResponseModel.fromJson(Map<String, dynamic> json) {
    final coursesList = (json['availableCourses'] as List? ?? [])
        .map((e) => AvailableCourseModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return AvailableCoursesResponseModel(
      minHours: json['minHours'] as int? ?? 0,
      maxHours: json['maxHours'] as int? ?? 18,
      courses: coursesList,
    );
  }
}
