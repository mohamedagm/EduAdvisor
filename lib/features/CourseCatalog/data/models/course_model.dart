class CourseModel {
  const CourseModel({
    required this.id,
    required this.courseCode,
    required this.courseName,
    required this.description,
    required this.creditHours,
    required this.type,
    required this.standardLevel,
    required this.standardSemester,
    required this.isDeleted,
    required this.createdBy,
    required this.createdAt,
    required this.updatedBy,
    required this.updatedAt,
    this.departmentName,
  });

  final String id;
  final String courseCode;
  final String courseName;
  final String description;
  final int creditHours;
  final String type;
  final int standardLevel;
  final int standardSemester;
  final String? departmentName;
  final bool isDeleted;
  final String createdBy;
  final String createdAt;
  final String updatedBy;
  final String updatedAt;

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String? ?? '',
      courseCode: json['courseCode'] as String? ?? '',
      courseName: json['courseName'] as String? ?? '',
      description: json['description'] as String? ?? '',
      creditHours: json['creditHours'] as int? ?? 0,
      type: json['type'] as String? ?? '',
      standardLevel: json['standardLevel'] as int? ?? 0,
      standardSemester: json['standardSemester'] as int? ?? 0,
      departmentName: json['departmentName'] as String?,
      isDeleted: json['isDeleted'] as bool? ?? false,
      createdBy: json['createdBy'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedBy: json['updatedBy'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );
  }

  String get displayCode => courseCode.isNotEmpty ? courseCode : '--';
  String get displayName => courseName.isNotEmpty ? courseName : 'Course';
  String get displayDescription =>
      description.isNotEmpty ? description : 'No description available';
  String get displayType => type.isNotEmpty ? type : '--';
  String get displayDepartment =>
      departmentName?.isNotEmpty == true ? departmentName! : 'General';
  String get displayCreditHours => creditHours.toString();
}
