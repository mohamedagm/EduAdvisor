import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCard extends StatelessWidget {
  final String code;
  final String title;
  final String progressPercentage;
  final int credits;

  const CourseCard({
    super.key,
    required this.code,
    required this.title,
    required this.progressPercentage,
    required this.credits,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42.r,
                height: 42.r,
                decoration: BoxDecoration(
                  color: context.themeColors.purpleContainer,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.menu_book_outlined,
                  color: AppColors.aiPurple,
                  size: 24.r,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
                decoration: BoxDecoration(
                  color: context.themeColors.card,
                  borderRadius: BorderRadius.circular(16.r),
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
                      progressPercentage,
                      style: AppTextStyles.bodyInterMedium14.copyWith(
                        fontSize: 13.sp,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.w),
          Text(
            code,
            style: AppTextStyles.poppinsRegular14.copyWith(
              fontSize: 13.sp,
              color: context.themeColors.textMuted,
            ),
          ),
          SizedBox(height: 4.w),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.interRegular16.copyWith(
              fontSize: 16.sp,
              color: context.themeColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.w,
                    ),
                    decoration: BoxDecoration(
                      color: context.themeColors.card,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: context.themeColors.border),
                    ),
                    child: Text(
                      context.l10n.courseCredits(credits.toString()),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.interRegular16.copyWith(
                        fontSize: 14.sp,
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
    );
  }
}
