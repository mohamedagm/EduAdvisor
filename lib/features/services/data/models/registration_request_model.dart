class RegistrationRequestModel {
  const RegistrationRequestModel({
    required this.id,
    required this.semesterName,
    required this.status,
    required this.submittedAt,
    required this.coursesCount,
    this.notes,
  });

  final String id;
  final String semesterName;
  final String status;
  final String submittedAt;
  final String? notes;
  final int coursesCount;

  factory RegistrationRequestModel.fromJson(Map<String, dynamic> json) {
    return RegistrationRequestModel(
      id: json['id'] as String? ?? '',
      semesterName: json['semesterName'] as String? ?? '',
      status: json['status'] as String? ?? '',
      submittedAt: json['submittedAt'] as String? ?? '',
      notes: json['notes'] as String?,
      coursesCount: json['coursesCount'] as int? ?? 0,
    );
  }

  String get displaySemester =>
      semesterName.isNotEmpty ? semesterName : 'Semester';

  String get displaySubmittedAt {
    if (submittedAt.isEmpty) return '--';

    return submittedAt.split('T').first;
  }
}
