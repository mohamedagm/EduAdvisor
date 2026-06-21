import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            context.l10n.recommendedCourses,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.heading3PoppinsReg16.copyWith(
              fontSize: 16.sp,
              color: context.themeColors.textPrimary,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          context.l10n.viewAll,
          maxLines: 1,
          style: AppTextStyles.poppinsRegular14.copyWith(
            fontSize: 14.sp,
            color: context.themeColors.info,
          ),
        ),
      ],
    );
  }
}
