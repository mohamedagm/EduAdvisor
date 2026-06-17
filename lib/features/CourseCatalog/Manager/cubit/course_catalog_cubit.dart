import 'package:edu_advisor/features/CourseCatalog/Manager/cubit/course_catalog_state.dart';
import 'package:edu_advisor/features/CourseCatalog/data/models/course_catalog_query_params.dart';
import 'package:edu_advisor/features/CourseCatalog/data/repo/course_catalog_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCatalogCubit extends Cubit<CourseCatalogState> {
  CourseCatalogCubit({required CourseCatalogRepo courseCatalogRepo})
    : _courseCatalogRepo = courseCatalogRepo,
      super(CourseCatalogState.initial());

  final CourseCatalogRepo _courseCatalogRepo;
  static const int _pageSize = 20;

  Future<void> loadCourses() async {
    if (state.isLoading) return;

    emit(
      state.copyWith(
        isLoading: true,
        isLoadingMore: false,
        search: '',
        clearFailure: true,
      ),
    );

    final result = await _courseCatalogRepo.getCourses();

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, courses: [], failure: failure)),
      (page) => emit(
        state.copyWith(
          isLoading: false,
          courses: page.items,
          pageNumber: page.pageNumber,
          totalCount: page.totalCount,
          totalPages: page.totalPages,
          hasNextPage: page.hasNextPage,
          clearFailure: true,
        ),
      ),
    );
  }

  Future<void> searchCourses(String search) async {
    final trimmedSearch = search.trim();

    if (state.isLoading && state.search == trimmedSearch) return;

    if (trimmedSearch.isEmpty) {
      await loadCourses();
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
        isLoadingMore: false,
        search: trimmedSearch,
        clearFailure: true,
      ),
    );

    final result = await _courseCatalogRepo.getCourses(
      queryParams: CourseCatalogQueryParams(
        search: trimmedSearch,
        pageSize: _pageSize,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, courses: [], failure: failure)),
      (page) => emit(
        state.copyWith(
          isLoading: false,
          courses: page.items,
          pageNumber: page.pageNumber,
          totalCount: page.totalCount,
          totalPages: page.totalPages,
          hasNextPage: page.hasNextPage,
          clearFailure: true,
        ),
      ),
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.isLoadingMore || !state.hasNextPage) return;

    emit(state.copyWith(isLoadingMore: true, clearFailure: true));

    final result = await _courseCatalogRepo.getCourses(
      queryParams: CourseCatalogQueryParams(
        pageNumber: state.pageNumber + 1,
        pageSize: _pageSize,
        search: state.search,
      ),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(state.copyWith(isLoadingMore: false, failure: failure)),
      (page) => emit(
        state.copyWith(
          isLoadingMore: false,
          courses: [...state.courses, ...page.items],
          pageNumber: page.pageNumber,
          totalCount: page.totalCount,
          totalPages: page.totalPages,
          hasNextPage: page.hasNextPage,
          clearFailure: true,
        ),
      ),
    );
  }
}
