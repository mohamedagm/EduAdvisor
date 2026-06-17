class CurrentUserModel {
  const CurrentUserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.isVerified,
    required this.rawData,
    this.studentCode,
    this.departmentName,
    this.profileImageUrl,
    this.gpa,
    this.completedCreditHours,
    this.level,
  });

  final String id;
  final String fullName;
  final String email;
  final String role;
  final bool isVerified;
  final String? studentCode;
  final String? departmentName;
  final String? profileImageUrl;
  final num? gpa;
  final num? completedCreditHours;
  final int? level;
  final Map<String, dynamic> rawData;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    final studentProfile = Map<String, dynamic>.from(
      json['studentProfile'] as Map? ?? {},
    );
    final advisorProfile = Map<String, dynamic>.from(
      json['advisorProfile'] as Map? ?? {},
    );
    final profile = studentProfile.isNotEmpty ? studentProfile : advisorProfile;

    return CurrentUserModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? '',
      isVerified: json['isVerified'] as bool? ?? false,
      studentCode: profile['studentCode'] as String?,
      departmentName: profile['departmentName'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      gpa: profile['gpa'] as num?,
      completedCreditHours: profile['completedHours'] as num?,
      level: profile['academicYear'] as int?,
      rawData: json,
    );
  }

  String get displayName => fullName.isNotEmpty ? fullName : 'Student';
  String get displayId => studentCode?.isNotEmpty == true ? studentCode! : id;
  String get displayDepartment =>
      departmentName?.isNotEmpty == true ? departmentName! : 'Department';
  String get displayGpa => gpa?.toString() ?? '--';
  String get displayCredits => completedCreditHours?.toString() ?? '--';
  String get displayLevel => level?.toString() ?? '--';
}
