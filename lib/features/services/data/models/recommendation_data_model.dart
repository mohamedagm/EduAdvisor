import 'package:edu_advisor/features/services/data/models/suggested_course_model.dart';

class RecommendationDataModel {
  const RecommendationDataModel({
    required this.success,
    required this.totalCreditHours,
    required this.maxAllowedHours,
    required this.suggestedCourses,
  });

  final bool success;
  final int totalCreditHours;
  final int maxAllowedHours;
  final List<SuggestedCourseModel> suggestedCourses;

  factory RecommendationDataModel.fromJson(Map<String, dynamic> json) {
    final coursesList = (json['suggestedCourses'] as List? ?? [])
        .map((e) => SuggestedCourseModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return RecommendationDataModel(
      success: json['success'] as bool? ?? false,
      totalCreditHours: json['totalCreditHours'] as int? ?? 0,
      maxAllowedHours: json['maxAllowedHours'] as int? ?? 0,
      suggestedCourses: coursesList,
    );
  }
}
