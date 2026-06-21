import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/features/CourseCatalog/Manager/cubit/course_catalog_cubit.dart';
import 'package:edu_advisor/features/CourseCatalog/data/repo/course_catalog_repo.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCatalogView extends StatelessWidget {
  const CourseCatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseCatalogCubit(courseCatalogRepo: getIt<CourseCatalogRepo>())
            ..loadCourses(),
      child: const CourseCatalogViewBody(),
    );
  }
}
