import 'dart:ui';

class CurrentUserModel {
  const CurrentUserModel({
    required this.role,
    required this.email,
    required this.fullNameAr,
    required this.fullNameEn,
    required this.departmentNameAr,
    required this.departmentNameEn,
    this.id = '',
    this.isVerified = false,
    this.profileImageUrl,
    this.phoneNumber,
    this.studentCode,
    this.level,
    this.completedCreditHours,
    this.gpa,
    this.advisorIsPending,
    this.studentsCount,
    this.pendingRequestsCount,
  });

  final String id;
  final String role;
  final String email;
  final String fullNameAr;
  final String fullNameEn;
  final String departmentNameAr;
  final String departmentNameEn;
  final bool isVerified;
  final String? profileImageUrl;
  final String? phoneNumber;
  final String? studentCode;
  final int? level;
  final num? completedCreditHours;
  final num? gpa;
  final bool? advisorIsPending;
  final int? studentsCount;
  final int? pendingRequestsCount;

  factory CurrentUserModel.fromJson(Map<String, dynamic> json) {
    return CurrentUserModel(
      id: json['id'] as String? ?? '',
      role: json['role'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullNameAr: json['fullNameAr'] as String? ?? '',
      fullNameEn: json['fullNameEn'] as String? ?? '',
      departmentNameAr: json['departmentNameAr'] as String? ?? '',
      departmentNameEn: json['departmentNameEn'] as String? ?? '',
      isVerified: json['isVerified'] as bool? ?? false,
      profileImageUrl: json['profileImageUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      studentCode: json['studentCode'] as String?,
      level: json['level'] as int?,
      completedCreditHours: json['completedHours'] as num?,
      gpa: json['gpa'] as num?,
      advisorIsPending: json['isPending'] as bool?,
      studentsCount: json['studentsCount'] as int?,
      pendingRequestsCount: json['pendingRequestsCount'] as int?,
    );
  }

  String get fullName => _firstNonEmpty([fullNameEn, fullNameAr], 'Student');
  String get departmentName =>
      _firstNonEmpty([departmentNameEn, departmentNameAr], 'Department');

  String nameFor(Locale locale) => locale.languageCode.toLowerCase() == 'ar'
      ? _firstNonEmpty([fullNameAr, fullNameEn], 'Student')
      : fullName;

  String departmentFor(Locale locale) =>
      locale.languageCode.toLowerCase() == 'ar'
          ? _firstNonEmpty([departmentNameAr, departmentNameEn], 'Department')
          : departmentName;

  static String _firstNonEmpty(List<String> candidates, String fallback) {
    for (final candidate in candidates) {
      if (candidate.trim().isNotEmpty) return candidate;
    }
    return fallback;
  }

  String get displayName => fullName;
  String get displayId => studentCode?.isNotEmpty == true ? studentCode! : id;
  String get displayDepartment => departmentName;
  String get displayPhone => phoneNumber?.isNotEmpty == true ? phoneNumber! : 'Not set';
  String get displayGpa => gpa?.toString() ?? '--';
  String get displayCredits => completedCreditHours?.toString() ?? '--';
  String get displayLevel => level?.toString() ?? '--';
  String get displayStudentsCount => studentsCount?.toString() ?? '--';
  String get displayPendingRequestsCount =>
      pendingRequestsCount?.toString() ?? '--';
}
