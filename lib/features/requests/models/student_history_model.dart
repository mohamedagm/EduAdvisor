class EnrollmentHistoryModel {
  final String registrationRequestId;
  final String semesterId;
  final String semesterNameEn;
  final String semesterNameAr;
  final String studentId;
  final int status;
  final DateTime? createdAt;
  final List<EnrolledCourseHistoryModel> courses;

  EnrollmentHistoryModel({
    required this.registrationRequestId,
    required this.semesterId,
    required this.semesterNameEn,
    required this.semesterNameAr,
    required this.studentId,
    required this.status,
    this.createdAt,
    required this.courses,
  });

  factory EnrollmentHistoryModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentHistoryModel(
      registrationRequestId: json['registrationRequestId']?.toString() ?? '',
      semesterId: json['semesterId']?.toString() ?? '',
      semesterNameEn: json['semesterNameEn']?.toString() ?? '',
      semesterNameAr: json['semesterNameAr']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      status: json['status'] is int
          ? json['status']
          : int.tryParse('${json['status']}') ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      courses: (json['courses'] as List? ?? [])
          .map((e) => EnrolledCourseHistoryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}


///////////////////////////////////
///
class EnrolledCourseHistoryModel {
  final String enrollmentId;
  final String semesterCourseId;
  final String courseId;
  final String semesterId;
  final String courseCode;
  final String courseNameEn;
  final String courseNameAr;
  final int creditHours;
  final double? coursePercentage;
  final double? courseGpa;
  final int status;

  EnrolledCourseHistoryModel({
    required this.enrollmentId,
    required this.semesterCourseId,
    required this.courseId,
    required this.semesterId,
    required this.courseCode,
    required this.courseNameEn,
    required this.courseNameAr,
    required this.creditHours,
    this.coursePercentage,
    this.courseGpa,
    required this.status,
  });

  factory EnrolledCourseHistoryModel.fromJson(Map<String, dynamic> json) {
    return EnrolledCourseHistoryModel(
      enrollmentId: json['enrollmentId']?.toString() ?? '',
      semesterCourseId: json['semesterCourseId']?.toString() ?? '',
      courseId: json['courseId']?.toString() ?? '',
      semesterId: json['semesterId']?.toString() ?? '',
      courseCode: json['courseCode']?.toString() ?? '',
      courseNameEn: json['courseNameEn']?.toString() ?? '',
      courseNameAr: json['courseNameAr']?.toString() ?? '',
      creditHours: json['creditHours'] is int
          ? json['creditHours']
          : int.tryParse('${json['creditHours']}') ?? 0,
      coursePercentage: (json['coursePercentage'] as num?)?.toDouble(),
      courseGpa: (json['courseGpa'] as num?)?.toDouble(),
      status: json['status'] is int
          ? json['status']
          : int.tryParse('${json['status']}') ?? 0,
    );
  }
}