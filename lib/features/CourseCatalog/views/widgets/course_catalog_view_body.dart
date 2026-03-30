import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/course_catalog_builder.dart';
import 'package:edu_advisor/features/CourseCatalog/views/widgets/search_text_form_field.dart';
import 'package:flutter/material.dart';

class CourseCatalogViewBody extends StatelessWidget {
  const CourseCatalogViewBody({super.key});

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

                SearchTextFormField(),
              ],
            ),
          ),

          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: CourseCatalogBuilder(),
            ),
          ),
        ],
      ),
    );
  }
}
