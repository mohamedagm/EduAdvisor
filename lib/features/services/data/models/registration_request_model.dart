class EnrollmentModel {
  const EnrollmentModel({
    required this.id,
    required this.semesterCourseId,
    required this.courseCode,
    required this.courseName,
    required this.creditHours,
    required this.status,
    this.rejectionReason,
  });

  final String id;
  final String semesterCourseId;
  final String courseCode;
  final String courseName;
  final int creditHours;
  final int status;
  final String? rejectionReason;

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['id'] as String? ?? '',
      semesterCourseId: json['semesterCourseId'] as String? ?? '',
      courseCode: json['courseCode'] as String? ?? '',
      courseName: json['courseName'] as String? ?? '',
      creditHours: json['creditHours'] as int? ?? 0,
      status: json['status'] as int? ?? 0,
      rejectionReason: json['rejectionReason'] as String?,
    );
  }
}

class RegistrationRequestModel {
  const RegistrationRequestModel({
    required this.id,
    required this.studentId,
    required this.studentCode,
    required this.studentName,
    required this.semesterId,
    required this.semesterName,
    required this.status,
    required this.submittedAt,
    required this.totalCreditHours,
    required this.enrollments,
    this.notes,
    this.processedAt,
    this.reviewedByAdvisorId,
  });

  final String id;
  final String studentId;
  final String studentCode;
  final String studentName;
  final String semesterId;
  final String semesterName;
  final int status;
  final String submittedAt;
  final int totalCreditHours;
  final List<EnrollmentModel> enrollments;
  final String? notes;
  final String? processedAt;
  final String? reviewedByAdvisorId;

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    final enrollmentsList = (json['enrollments'] as List? ?? [])
        .map(
          (e) => EnrollmentModel.fromJson(
            Map<String, dynamic>.from(e as Map? ?? {}),
          ),
        )
        .toList();

    return RegistrationRequestModel(
      id: json['id'] as String? ?? '',
      studentId: json['studentId'] as String? ?? '',
      studentCode: json['studentCode'] as String? ?? '',
      studentName: json['studentName'] as String? ?? '',
      semesterId: json['semesterId'] as String? ?? '',
      semesterName: json['semesterName'] as String? ?? '',
      status: json['status'] as int? ?? 0,
      submittedAt: json['submittedAt'] as String? ?? '',
      totalCreditHours: json['totalCreditHours'] as int? ?? 0,
      enrollments: enrollmentsList,
      notes: json['notes'] as String?,
      processedAt: json['processedAt'] as String?,
      reviewedByAdvisorId: json['reviewedByAdvisorId'] as String?,
    );
  }

  int get coursesCount => enrollments.length;

  String get displaySemester =>
      semesterName.isNotEmpty ? semesterName : 'Semester';

  String get displaySubmittedAt {
    if (submittedAt.isEmpty) return '--';
    return submittedAt.split('T').first;
  }
}
