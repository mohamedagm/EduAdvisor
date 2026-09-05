class PrerequisiteCourseModel {
  final String id;
  final String courseCode;
  final String courseNameEN;
  final String courseNameAR;
  final int creditHours;

  PrerequisiteCourseModel({
    required this.id,
    required this.courseCode,
    required this.courseNameEN,
    required this.courseNameAR,
    required this.creditHours,
  });

  factory PrerequisiteCourseModel.fromJson(Map<String, dynamic> json) {
    return PrerequisiteCourseModel(
      id: json['id'] ?? '',
      courseCode: json['courseCode'] ?? '',
      courseNameEN: json['courseNameEN'] ?? '',
      courseNameAR: json['courseNameAR'] ?? '',
      creditHours: json['creditHours'] ?? 0,
    );
  }
}