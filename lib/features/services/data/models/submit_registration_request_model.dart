class SubmitRegistrationRequestModel {
  const SubmitRegistrationRequestModel({
    required this.semesterCourseIds,
    this.notes,
  });

  final List<String> semesterCourseIds;
  final String? notes;

  Map<String, dynamic> toJson() {
    return {
      'semesterCourses': semesterCourseIds,
      'notes': notes?.trim() ?? '',
    };
  }
}
