import 'dart:async';
import 'package:edu_advisor/core/api/api_constants.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/CourseCatalog/Manager/cubit/course_catalog_cubit.dart';
import 'package:edu_advisor/features/CourseCatalog/Manager/cubit/course_catalog_state.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_builder.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_empty.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_shimmer.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/search_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> _openCourseTree(BuildContext context) async {
    final uri = Uri.parse(ApiConstants.courseTreeUrl);
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      AppToast.error(
        context,
        title: context.l10n.courseTreeLaunchErrorTitle,
        description: context.l10n.courseTreeLaunchErrorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        spacing: 12.w,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.r),
              ),
            ),
            child: Column(
              spacing: 12.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.courseCatalogTitle,
                        style: AppTextStyles.heading1_20b.responsive.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _openCourseTree(context),
                      child: Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.help_outline,
                          color: AppColors.white,
                          size: 20.r,
                        ),
                      ),
                    ),
                  ],
                ),

                SearchTextFormField(onChanged: _onSearchChanged),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
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
          Icon(
            Icons.error_outline,
            color: context.colorScheme.error,
            size: 40.r,
          ),
          SizedBox(height: 8.w),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
              color: context.themeColors.textSecondary,
            ),
          ),
          SizedBox(height: 12.w),
          TextButton(
            onPressed: context.read<CourseCatalogCubit>().loadCourses,
            child: Text(context.l10n.retry),
          ),
        ],
      ),
    );
  }
}
