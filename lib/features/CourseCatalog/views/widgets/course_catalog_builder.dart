import 'package:edu_advisor/features/CourseCatalog/data/models/course_model.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_item.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_shimmer.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_details_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCatalogBuilder extends StatelessWidget {
  const CourseCatalogBuilder({
    super.key,
    required this.courses,
    required this.onLoadMore,
    this.isLoadingMore = false,
  });

  final List<CourseModel> courses;
  final VoidCallback onLoadMore;
  final bool isLoadingMore;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: courses.length + (isLoadingMore ? 1 : 0),
      separatorBuilder: (context, index) {
        return SizedBox(height: 12.w);
      },
      itemBuilder: (context, index) {
        if (index == courses.length) {
          return const CourseCatalogLoadMoreShimmer();
        }

        if (index == courses.length - 1) {
          WidgetsBinding.instance.addPostFrameCallback((_) => onLoadMore());
        }

        final course = courses[index];

        return GestureDetector(
          onTap: () => _showCourseDetails(context, course),

          child: CourseCatalogItem(course: course),
        );
      },
    );
  }
}

void _showCourseDetails(BuildContext context, CourseModel course) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
    ),
    builder: (_) => CourseDetailsSheet(course: course),
  );
}
