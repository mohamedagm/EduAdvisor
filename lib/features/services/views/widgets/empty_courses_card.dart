import 'package:flutter/material.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyCoursesCard extends StatelessWidget {
  const EmptyCoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              color: context.themeColors.mutedSurface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: context.themeColors.textMuted,
              size: 32.r,
            ),
          ),
          SizedBox(height: 16.w),
          Text(
            context.l10n.noCoursesSelected,
            textAlign: TextAlign.center,
            style: AppTextStyles.heading3PoppinsReg16.responsive.copyWith(
              color: context.themeColors.textSecondary,
            ),
          ),
          SizedBox(height: 8.w),
          Text(
            context.l10n.addCourseToStart,
            textAlign: TextAlign.center,
            style: AppTextStyles.poppinsRegular14.responsive.copyWith(
              color: context.themeColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
