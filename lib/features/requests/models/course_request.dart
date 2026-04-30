class CourseRequest {
  final String code;
  final String name;
  final int credits;
  final String date;
  final String? missingPrereq;

  CourseRequest({
    required this.code,
    required this.name,
    required this.credits,
    required this.date,
    this.missingPrereq,
  });
}