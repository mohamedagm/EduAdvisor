class DepartmentsQueryParams {
  const DepartmentsQueryParams({
    this.searchTerm,
    this.facultyId,
    this.isActive,
    this.includeDeleted,
    this.pageNumber,
    this.pageSize,
    this.sortBy,
    this.sortAscending,
  });

  final String? searchTerm;
  final String? facultyId;
  final bool? isActive;
  final bool? includeDeleted;
  final int? pageNumber;
  final int? pageSize;
  final String? sortBy;
  final bool? sortAscending;

  Map<String, dynamic> toMap() {
    return {
      if (searchTerm?.trim().isNotEmpty == true) 'SearchTerm': searchTerm!.trim(),
      if (facultyId?.trim().isNotEmpty == true) 'FacultyId': facultyId!.trim(),
      if (isActive != null) 'IsActive': isActive,
      if (includeDeleted != null) 'IncludeDeleted': includeDeleted,
      if (pageNumber != null) 'PageNumber': pageNumber,
      if (pageSize != null) 'PageSize': pageSize,
      if (sortBy?.trim().isNotEmpty == true) 'SortBy': sortBy!.trim(),
      if (sortAscending != null) 'SortAscending': sortAscending,
    };
  }
}
