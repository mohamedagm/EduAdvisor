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
      if (notes != null && notes!.trim().isNotEmpty) 'notes': notes!.trim(),
    };
  }
}
