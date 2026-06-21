import 'package:edu_advisor/features/profile/data/models/student_course_model.dart';

class StudentCoursesModel {
  const StudentCoursesModel({
    required this.completed,
    required this.inProgress,
    required this.remaining,
  });

  final List<StudentCourseModel> completed;
  final List<StudentCourseModel> inProgress;
  final List<StudentCourseModel> remaining;

  factory StudentCoursesModel.fromJson(Map<String, dynamic> json) {
    return StudentCoursesModel(
      completed: _coursesFromJson(json['completed']),
      inProgress: _coursesFromJson(json['inProgress']),
      remaining: _coursesFromJson(json['remaining']),
    );
  }

  static List<StudentCourseModel> _coursesFromJson(dynamic value) {
    final courses = value as List? ?? [];

    return courses
        .map(
          (course) => StudentCourseModel.fromJson(
            Map<String, dynamic>.from(course as Map? ?? {}),
          ),
        )
        .toList();
  }
}
