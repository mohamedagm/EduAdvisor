import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/CourseCatalog/data/models/course_model.dart';

class CourseCatalogState {
  const CourseCatalogState({
    required this.courses,
    required this.isLoading,
    required this.isLoadingMore,
    required this.search,
    required this.pageNumber,
    required this.totalCount,
    required this.totalPages,
    required this.hasNextPage,
    this.failure,
  });

  final List<CourseModel> courses;
  final bool isLoading;
  final bool isLoadingMore;
  final String search;
  final int pageNumber;
  final int totalCount;
  final int totalPages;
  final bool hasNextPage;
  final Failure? failure;

  factory CourseCatalogState.initial() {
    return const CourseCatalogState(
      courses: [],
      isLoading: false,
      isLoadingMore: false,
      search: '',
      pageNumber: 1,
      totalCount: 0,
      totalPages: 1,
      hasNextPage: false,
    );
  }

  bool get hasError => failure != null;
  bool get isEmpty => courses.isEmpty && !isLoading;

  CourseCatalogState copyWith({
    List<CourseModel>? courses,
    bool? isLoading,
    bool? isLoadingMore,
    String? search,
    int? pageNumber,
    int? totalCount,
    int? totalPages,
    bool? hasNextPage,
    Failure? failure,
    bool clearFailure = false,
  }) {
    return CourseCatalogState(
      courses: courses ?? this.courses,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      search: search ?? this.search,
      pageNumber: pageNumber ?? this.pageNumber,
      totalCount: totalCount ?? this.totalCount,
      totalPages: totalPages ?? this.totalPages,
      hasNextPage: hasNextPage ?? this.hasNextPage,
      failure: clearFailure ? null : failure ?? this.failure,
    );
  }
}
