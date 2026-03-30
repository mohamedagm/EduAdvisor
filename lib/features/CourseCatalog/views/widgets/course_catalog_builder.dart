import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_item.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_details_sheet.dart';
import 'package:flutter/material.dart';

class CourseCatalogBuilder extends StatelessWidget {
  const CourseCatalogBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 12);
      },
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _showCourseDetails(context),

          child: CourseCatalogItem(),
        );
      },
    );
  }
}

void _showCourseDetails(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
    ),
    builder: (_) => const CourseDetailsSheet(),
  );
}
