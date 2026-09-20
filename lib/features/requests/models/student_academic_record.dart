class StudentAcademicRecord {
  final String studentId;
  final String studentCode;
  final String fullNameAr;
  final String fullNameEn;
  final String email;
  final String? phoneNumber;
  final String departmentId;
  final String departmentName;
  final String facultyName;
  final int currentLevel;
  final double cumulativeGpa;
  final int totalCompletedHours;
  final int totalRemainingHours;
  final String academicStanding;
  final String advisorName;

  StudentAcademicRecord({
    required this.studentId,
    required this.studentCode,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.email,
    this.phoneNumber,
    required this.departmentId,
    required this.departmentName,
    required this.facultyName,
    required this.currentLevel,
    required this.cumulativeGpa,
    required this.totalCompletedHours,
    required this.totalRemainingHours,
    required this.academicStanding,
    required this.advisorName,
  });

  factory StudentAcademicRecord.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return StudentAcademicRecord(
      studentId: data['studentId'] ?? '',
      studentCode: data['studentCode'] ?? '',
      fullNameAr: data['fullNameAr'] ?? '',
      fullNameEn: data['fullNameEn'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'],
      departmentId: data['departmentId'] ?? '',
      departmentName: data['departmentName'] ?? '',
      facultyName: data['facultyName'] ?? '',
      currentLevel: data['currentLevel'] ?? 0,
      cumulativeGpa: (data['cumulativeGpa'] as num?)?.toDouble() ?? 0.0,
      totalCompletedHours: data['totalCompletedHours'] ?? 0,
      totalRemainingHours: data['totalRemainingHours'] ?? 0,
      academicStanding: data['academicStanding'] ?? '',
      advisorName: data['advisorName'] ?? '',
    );
  }
}