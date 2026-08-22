class EnrollmentModel {
  final String id;
  final String semesterCourseId;
  final String courseCode;
  final String courseName;
  final int creditHours;
  final double? coursePercentage;
  final double? courseGpa;
  final int status;
  final String? rejectionReason;

  EnrollmentModel({
    required this.id,
    required this.semesterCourseId,
    required this.courseCode,
    required this.courseName,
    required this.creditHours,
    this.coursePercentage,
    this.courseGpa,
    required this.status,
    this.rejectionReason,
  });

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) {
    return EnrollmentModel(
      id: json['id']?.toString() ?? '',
      semesterCourseId: json['semesterCourseId']?.toString() ?? '',
      courseCode: json['courseCode']?.toString() ?? '',
      courseName: json['courseName']?.toString() ?? '',
      creditHours: json['creditHours'] is int
          ? json['creditHours']
          : int.tryParse('${json['creditHours']}') ?? 0,
      coursePercentage: (json['coursePercentage'] as num?)?.toDouble(),
      courseGpa: (json['courseGpa'] as num?)?.toDouble(),
      status: json['status'] is int
          ? json['status']
          : int.tryParse('${json['status']}') ?? 0,
      rejectionReason: json['rejectionReason'] as String?,
    );
  }
}

class StudentRequest {
  final String id;
  final String studentId;
  final String studentCode;
  final String studentName;
  final String semesterId;
  final String semesterName;
  final int status; // int: 0 = Pending, 1 = Approved, 2 = Rejected
  final String? notes;
  final DateTime submittedAt;
  final int totalCreditHours;
  final List<EnrollmentModel> enrollments;

  StudentRequest({
    required this.id,
    required this.studentId,
    required this.studentCode,
    required this.studentName,
    required this.semesterId,
    required this.semesterName,
    required this.status,
    this.notes,
    required this.submittedAt,
    required this.totalCreditHours,
    required this.enrollments,
  });

  factory StudentRequest.fromJson(Map<String, dynamic> json) {
    return StudentRequest(
      id: json['id']?.toString() ?? '',
      studentId: json['studentId']?.toString() ?? '',
      studentCode: (json['studentCode'] ?? '').toString(),
      studentName: json['studentName']?.toString() ?? '',
      semesterId: json['semesterId']?.toString() ?? '',
      semesterName: json['semesterName']?.toString() ?? '',
      status: json['status'] is int
          ? json['status']
          : int.tryParse('${json['status']}') ?? 0,
      notes: json['notes'] as String?,
      submittedAt: DateTime.tryParse(json['submittedAt']?.toString() ?? '') ??
          DateTime.now(),
      totalCreditHours: json['totalCreditHours'] is int
          ? json['totalCreditHours']
          : int.tryParse('${json['totalCreditHours']}') ?? 0,
      enrollments: (json['enrollments'] as List<dynamic>?)
              ?.map((e) => EnrollmentModel.fromJson(Map<String, dynamic>.from(e)))
              .toList() ??
          [],
    );
  }


  int get coursesCount => enrollments.length;
  String get semester => semesterName;
  
  String get statusName {
    switch (status) {
      case 2:
        return 'Approved';
      case 3:
        return 'Rejected';
      case 1:
      default:
        return 'Pending';
    }
  }

  StudentRequest copyWith({
    String? id,
    String? studentId,
    String? studentCode,
    String? studentName,
    String? semesterId,
    String? semesterName,
    int? status,
    String? notes,
    DateTime? submittedAt,
    int? totalCreditHours,
    List<EnrollmentModel>? enrollments,
  }) {
    return StudentRequest(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentCode: studentCode ?? this.studentCode,
      studentName: studentName ?? this.studentName,
      semesterId: semesterId ?? this.semesterId,
      semesterName: semesterName ?? this.semesterName,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      submittedAt: submittedAt ?? this.submittedAt,
      totalCreditHours: totalCreditHours ?? this.totalCreditHours,
      enrollments: enrollments ?? this.enrollments,
    );
  }
}