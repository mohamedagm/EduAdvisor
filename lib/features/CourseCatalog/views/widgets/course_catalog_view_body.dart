import 'dart:async';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/CourseCatalog/Manager/cubit/course_catalog_cubit.dart';
import 'package:edu_advisor/features/CourseCatalog/Manager/cubit/course_catalog_state.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_builder.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_empty.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_shimmer.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/search_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCatalogViewBody extends StatefulWidget {
  const CourseCatalogViewBody({super.key});

  @override
  State<CourseCatalogViewBody> createState() => _CourseCatalogViewBodyState();
}

class _CourseCatalogViewBodyState extends State<CourseCatalogViewBody> {
  Timer? _searchDebounce;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 450), () {
      if (!mounted) return;
      context.read<CourseCatalogCubit>().searchCourses(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        spacing: 12,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Course Catalog',
                  style: AppTextStyles.heading1_20b.copyWith(
                    color: AppColors.white,
                  ),
                ),

                SearchTextFormField(onChanged: _onSearchChanged),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: BlocBuilder<CourseCatalogCubit, CourseCatalogState>(
                builder: (context, state) {
                  if (state.isLoading && state.courses.isEmpty) {
                    return const CourseCatalogShimmer();
                  }

                  if (state.hasError && state.courses.isEmpty) {
                    return _CourseCatalogError(message: state.failure!.message);
                  }

                  if (state.isEmpty) {
                    return const Center(child: CourseCatalogEmpty());
                  }

                  return CourseCatalogBuilder(
                    courses: state.courses,
                    isLoadingMore: state.isLoadingMore,
                    onLoadMore: context.read<CourseCatalogCubit>().loadMore,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseCatalogError extends StatelessWidget {
  const _CourseCatalogError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, color: context.colorScheme.error, size: 40),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyInterMedium14.copyWith(
              color: context.themeColors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: context.read<CourseCatalogCubit>().loadCourses,
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
