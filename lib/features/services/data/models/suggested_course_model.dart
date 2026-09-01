class SuggestedCourseModel {
  const SuggestedCourseModel({
    required this.code,
    required this.name,
    required this.hours,
    required this.advisorScore,
  });

  final String code;
  final String name;
  final int hours;
  final num advisorScore;

  factory SuggestedCourseModel.fromJson(Map<String, dynamic> json) {
    return SuggestedCourseModel(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      hours: json['hours'] as int? ?? 0,
      advisorScore: json['advisorScore'] as num? ?? 0,
    );
  }
}
