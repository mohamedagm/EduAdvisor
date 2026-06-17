import 'package:edu_advisor/features/CourseCatalog/data/models/course_model.dart';

class CourseCatalogPageModel {
  const CourseCatalogPageModel({
    required this.items,
    required this.pageNumber,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  final List<CourseModel> items;
  final int pageNumber;
  final int totalCount;
  final int totalPages;
  final bool hasPreviousPage;
  final bool hasNextPage;

  factory CourseCatalogPageModel.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List? ?? [];

    return CourseCatalogPageModel(
      items: items
          .map(
            (course) => CourseModel.fromJson(
              Map<String, dynamic>.from(course as Map? ?? {}),
            ),
          )
          .toList(),
      pageNumber: json['pageNumber'] as int? ?? 1,
      totalCount: json['totalCount'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 1,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
    );
  }
}
