import 'package:edu_advisor/features/services/data/models/available_course_model.dart';
import 'package:edu_advisor/features/services/data/models/registration_request_model.dart';
import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('provides English and Arabic services translations', () async {
    final english = await AppLocalizations.delegate.load(const Locale('en'));
    final arabic = await AppLocalizations.delegate.load(const Locale('ar'));

    expect(english.courseRegistrationTitle, 'Course Registration');
    expect(arabic.courseRegistrationTitle, 'تسجيل المقررات');
    expect(english.selectedCoursesCount(3), 'Selected Courses (3)');
    expect(arabic.selectedCoursesCount(3), 'المقررات المختارة (3)');
    expect(english.addMoreCreditHours(2), 'Add 2 more credit hours');
    expect(arabic.addMoreCreditHours(2), 'أضف ساعتين معتمدتين');
    expect(english.coursesCount(4), '4 courses');
    expect(arabic.coursesCount(4), '4 مقررات');
  });

  test('keeps changing backend values untouched', () {
    final course = AvailableCourseModel.fromJson({
      'semesterCourseId': 'semester-course-1',
      'courseId': 'course-1',
      'courseCode': 'BACKEND-401',
      'courseName': 'Backend Controlled Course Name',
      'creditHours': 3,
      'isRetake': false,
    });
    final request = RegistrationRequestModel.fromJson({
      'id': 'request-1',
      'semesterName': 'Backend Semester 2099',
      'status': 'Pending',
      'submittedAt': '2099-10-01T12:00:00',
      'notes': 'Backend advisor note',
      'coursesCount': 2,
    });

    expect(course.courseCode, 'BACKEND-401');
    expect(course.courseName, 'Backend Controlled Course Name');
    expect(request.semesterName, 'Backend Semester 2099');
    expect(request.status, 'Pending');
    expect(request.notes, 'Backend advisor note');
  });
}
