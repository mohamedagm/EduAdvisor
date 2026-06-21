class CourseCatalogQueryParams {
  const CourseCatalogQueryParams({
    this.pageNumber = 1,
    this.pageSize = 20,
    this.search,
    this.isDeleted = false,
  });

  final int pageNumber;
  final int pageSize;
  final String? search;
  final bool? isDeleted;

  Map<String, dynamic> toMap() {
    return {
      'PageNumber': pageNumber,
      'PageSize': pageSize,
      if (search?.trim().isNotEmpty == true) 'Search': search!.trim(),
      if (isDeleted != null) 'IsDeleted': isDeleted,
    };
  }
}
