import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Tag extends StatelessWidget {
  final String label;
  const Tag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
      decoration: BoxDecoration(
        color: context.themeColors.mutedSurface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
          color: context.themeColors.textPrimary,
        ),
      ),
    );
  }
}
