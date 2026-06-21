class StudentRequest {
  final String id; // registrationRequestId - id الطلب نفسه (يُستخدم مع approve/{id})
  final String studentId; // id الطالب نفسه
  final String studentName;
  final String studentCode;
  final String? studentPhotoUrl;
  final String department;
  final int academicYear;
  final int coursesCount;
  String status;
  final DateTime submittedAt;

  StudentRequest({
    required this.id,
    required this.studentId,
    required this.studentName,
    required this.studentCode,
    this.studentPhotoUrl,
    required this.department,
    required this.academicYear,
    required this.coursesCount,
    required this.status,
    required this.submittedAt,
  });

  // 📌 الحقول دي مطابقة بالظبط لشكل الـ response الحقيقي من
  // GET /api/v1/Advisors/pending:
  // registrationRequestId, studentId, studentName, studentCode,
  // studentPhotoUrl, departmentName, academicYear, submittedAt,
  // coursesCount, status
  factory StudentRequest.fromJson(Map<String, dynamic> json) {
    final rawId = json['registrationRequestId'] ??
        json['requestId'] ??
        json['id'] ??
        json['registrationRequestID'] ??
        '';
    final rawStudentId = json['studentId'] ??
        json['studentID'] ??
        json['student_id'] ??
        '';
    final rawStatus = json['status'] ?? json['requestStatus'] ?? 'Pending';

    return StudentRequest(
      id: rawId.toString(),
      studentId: rawStudentId.toString(),
      studentName: json['studentName'] ?? '',
      studentCode: (json['studentCode'] ?? '').toString(),
      studentPhotoUrl: json['studentPhotoUrl'] as String?,
      department: json['departmentName'] ?? '',
      academicYear: json['academicYear'] is int
          ? json['academicYear']
          : int.tryParse('${json['academicYear']}') ?? 1,
      coursesCount: json['coursesCount'] is int
          ? json['coursesCount']
          : int.tryParse('${json['coursesCount']}') ?? 0,
      status: rawStatus.toString(),
      submittedAt:
          DateTime.tryParse(json['submittedAt']?.toString() ?? '') ??
              DateTime.now(),
    );
  }

  StudentRequest copyWith({
    String? id,
    String? studentId,
    String? studentName,
    String? studentCode,
    String? studentPhotoUrl,
    String? department,
    int? academicYear,
    int? coursesCount,
    String? status,
    DateTime? submittedAt,
  }) {
    return StudentRequest(
      id: id ?? this.id,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      studentCode: studentCode ?? this.studentCode,
      studentPhotoUrl: studentPhotoUrl ?? this.studentPhotoUrl,
      department: department ?? this.department,
      academicYear: academicYear ?? this.academicYear,
      coursesCount: coursesCount ?? this.coursesCount,
      status: status ?? this.status,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  // 📌 خصائص مساعدة عشان نحافظ على توافق الـ UI الحالي اللي بيستخدم
  // studentName / semester / major (الكروت والـ widgets القديمة)
  String get semester => 'Year $academicYear';
  String get major => department;
}

////////////////////////

final List<StudentRequest> dummyRequests = [
  StudentRequest(
    id: '1',
    studentId: 's1',
    studentName: 'Aliaa Mohamed',
    studentCode: '2023070',
    department: 'Information System',
    academicYear: 4,
    coursesCount: 3,
    status: 'Pending',
    submittedAt: DateTime.now(),
  ),
  StudentRequest(
    id: '2',
    studentId: 's2',
    studentName: 'Ahmed Hassan',
    studentCode: '2023071',
    department: 'Computer Science',
    academicYear: 3,
    coursesCount: 4,
    status: 'Approved',
    submittedAt: DateTime.now(),
  ),
  StudentRequest(
    id: '3',
    studentId: 's3',
    studentName: 'Nour Ibrahim',
    studentCode: '2023072',
    department: 'Software Engineering',
    academicYear: 5,
    coursesCount: 2,
    status: 'Rejected',
    submittedAt: DateTime.now(),
  ),
];