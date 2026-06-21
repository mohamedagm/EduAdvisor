import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCard extends StatelessWidget {
  final String imageUrl;
  final String code;
  final String title;
  final String progressPercentage;
  final int credits;

  const CourseCard({
    super.key,
    required this.imageUrl,
    required this.code,
    required this.title,
    required this.progressPercentage,
    required this.credits,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                  child: AppShimmerNetworkImage(
                    imageUrl: imageUrl,
                    errorWidget: ColoredBox(
                      color: context.themeColors.mutedSurface,
                      child: Center(
                        child: Icon(Icons.school_outlined, size: 24.r),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 8.w,
                right: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border_rounded,
                        size: 13.r,
                        color: context.colorScheme.secondary,
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        progressPercentage,
                        style: AppTextStyles.bodyInterMedium14.copyWith(
                          fontSize: 14.sp,
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              spacing: 4.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: AppTextStyles.poppinsRegular14.copyWith(
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyles.interRegular16.copyWith(
                    fontSize: 16.sp,
                    color: context.themeColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 2.w,
                          ),
                          decoration: BoxDecoration(
                            color: context.themeColors.card,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: context.themeColors.border,
                            ),
                          ),
                          child: Text(
                            context.l10n.courseCredits(credits.toString()),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.interRegular16.copyWith(
                              fontSize: 16.sp,
                              color: context.themeColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 22.r,
                      color: context.themeColors.textSecondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
