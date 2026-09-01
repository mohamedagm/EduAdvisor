import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/home/data/models/recommended_course_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedCoursesListView extends StatelessWidget {
  const RecommendedCoursesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.themeColors.card,
        elevation: 0,
        title: Text(
          context.l10n.recommendedCourses,
          style: AppTextStyles.heading1_20b.copyWith(
            fontSize: 18.sp,
            color: context.themeColors.textPrimary,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: recommendedCourses.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.w),
        itemBuilder: (context, index) {
          return _RecommendedCourseTile(course: recommendedCourses[index]);
        },
      ),
    );
  }
}

class _RecommendedCourseTile extends StatelessWidget {
  const _RecommendedCourseTile({required this.course});

  final RecommendedCourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 46.r,
            height: 46.r,
            decoration: BoxDecoration(
              color: context.themeColors.purpleContainer,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.menu_book_outlined,
              color: AppColors.aiPurple,
              size: 26.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.code,
                  style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                    color: context.themeColors.textMuted,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 3.w),
                Text(
                  course.title,
                  style: AppTextStyles.interRegular16.responsive.copyWith(
                    color: context.themeColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.w),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.w,
                      ),
                      decoration: BoxDecoration(
                        color: context.themeColors.card,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: context.themeColors.border),
                      ),
                      child: Text(
                        context.l10n.courseCredits(course.credits.toString()),
                        style: AppTextStyles.bodyInterRegular12.responsive
                            .copyWith(
                              color: context.themeColors.textPrimary,
                            ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.w,
                      ),
                      decoration: BoxDecoration(
                        color: context.themeColors.card,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: context.themeColors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star_border_rounded,
                            size: 13.r,
                            color: context.colorScheme.secondary,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            course.progressPercentage,
                            style: AppTextStyles.bodyInterRegular12.responsive
                                .copyWith(color: context.colorScheme.secondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 4.w),
          Icon(
            Icons.chevron_right_rounded,
            size: 24.r,
            color: context.themeColors.textMuted,
          ),
        ],
      ),
    );
  }
}
