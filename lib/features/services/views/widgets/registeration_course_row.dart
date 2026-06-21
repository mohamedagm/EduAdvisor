import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationCourseRow extends StatelessWidget {
  final String code;
  final String name;
  final String credits;

  const RegistrationCourseRow({
    super.key,
    required this.code,
    required this.name,
    required this.credits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            color: context.colorScheme.primary,
            size: 20.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                    color: context.themeColors.textPrimary,
                  ),
                ),
                if (name.isNotEmpty)
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                      color: context.themeColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
            decoration: BoxDecoration(
              color: context.themeColors.card,
              border: Border.all(color: context.themeColors.border),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              credits,
              style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                color: context.themeColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
