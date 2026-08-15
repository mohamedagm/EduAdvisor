import 'package:edu_advisor/features/auth/data/models/department_model.dart';

class PaginatedDepartmentsModel {
  final List<DepartmentModel> items;
  final int pageNumber;
  final int totalCount;
  final int totalPages;
  final bool hasPreviousPage;
  final bool hasNextPage;

  const PaginatedDepartmentsModel({
    required this.items,
    required this.pageNumber,
    required this.totalCount,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
  });

  factory PaginatedDepartmentsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedDepartmentsModel(
      items: (json['items'] as List<dynamic>)
          .map((item) => DepartmentModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      pageNumber: json['pageNumber'] as int,
      totalCount: json['totalCount'] as int,
      totalPages: json['totalPages'] as int,
      hasPreviousPage: json['hasPreviousPage'] as bool,
      hasNextPage: json['hasNextPage'] as bool,
    );
  }
}
