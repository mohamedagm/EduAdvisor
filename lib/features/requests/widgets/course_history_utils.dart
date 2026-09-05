import 'package:edu_advisor/features/requests/models/student_history_model.dart';

Map<String, double> buildBestGpaPerCourse(
  List<EnrollmentHistoryModel> history,
) {
  final Map<String, double> bestGpaPerCourse = {};

  for (final semester in history) {
    for (final course in semester.courses) {
      if (course.courseGpa == null) continue;

      final current = bestGpaPerCourse[course.courseId];
      if (current == null || course.courseGpa! > current) {
        bestGpaPerCourse[course.courseId] = course.courseGpa!;
      }
    }
  }

  return bestGpaPerCourse;
}
