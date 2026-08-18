class CoursePrerequisiteModel {
  const CoursePrerequisiteModel({
    required this.id,
    required this.courseCode,
    required this.courseNameEN,
    required this.courseNameAR,
    required this.creditHours,
    required this.type,
    required this.isActive,
  });

  final String id;
  final String courseCode;
  final String courseNameEN;
  final String courseNameAR;
  final int creditHours;
  final String type;
  final bool isActive;

  factory CoursePrerequisiteModel.fromJson(Map<String, dynamic> json) {
    return CoursePrerequisiteModel(
      id: json['id'] as String? ?? '',
      courseCode: json['courseCode'] as String? ?? '',
      courseNameEN: json['courseNameEN'] as String? ?? '',
      courseNameAR: json['courseNameAR'] as String? ?? '',
      creditHours: json['creditHours'] as int? ?? 0,
      type: json['type']?.toString() ?? '',
      isActive: json['isActive'] as bool? ?? false,
    );
  }
}
