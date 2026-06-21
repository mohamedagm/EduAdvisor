class StudentCourseModel {
  const StudentCourseModel({
    required this.courseId,
    required this.code,
    required this.name,
    required this.creditHours,
    required this.status,
    this.grade,
  });

  final String courseId;
  final String code;
  final String name;
  final int creditHours;
  final String status;
  final String? grade;

  factory StudentCourseModel.fromJson(Map<String, dynamic> json) {
    return StudentCourseModel(
      courseId: json['courseId'] as String? ?? '',
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      creditHours: json['creditHours'] as int? ?? 0,
      grade: json['grade']?.toString(),
      status: json['status'] as String? ?? '',
    );
  }

  double get progress {
    switch (status.trim().toLowerCase()) {
      case 'completed':
        return 1;
      case 'inprogress':
      case 'in progress':
        return 0.5;
      default:
        return 0;
    }
  }

  String get displayCode => code.isNotEmpty ? code : '--';
  String get displayName => name.isNotEmpty ? name : 'Course';
  String get displayCreditHours => creditHours.toString();
}
