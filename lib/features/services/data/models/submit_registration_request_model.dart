class SubmitRegistrationRequestModel {
  const SubmitRegistrationRequestModel({required this.semesterCourseIds});

  final List<String> semesterCourseIds;

  Map<String, dynamic> toJson() {
    return {'semesterCourseIds': semesterCourseIds};
  }
}
