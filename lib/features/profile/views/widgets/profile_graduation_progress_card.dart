import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileGraduationProgressCard extends StatelessWidget {
  const ProfileGraduationProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: context.themeColors.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: context.themeColors.border, width: 2.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.progressToGraduation,
              style: AppTextStyles.heading2PoppinsSb18.responsive,
            ),
            SizedBox(height: 12.w),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    context.l10n.creditsCompleted,
                    style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                      color: context.themeColors.textSecondary,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  context.l10n.creditsRatio('65', '140'),
                  style: AppTextStyles.bodyInterMedium14.responsive,
                ),
              ],
            ),

            SizedBox(height: 8.w),

            LinearProgressIndicator(
              color: context.themeColors.textPrimary,
              backgroundColor: context.colorScheme.outline,
              minHeight: 12.w,
              value: 65 / 140,
              borderRadius: BorderRadius.circular(10.r),
            ),

            SizedBox(height: 8.w),

            Text(
              context.l10n.creditsRemaining(75),
              style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
