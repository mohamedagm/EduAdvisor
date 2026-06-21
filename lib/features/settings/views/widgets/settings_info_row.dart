import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsInfoRow extends StatelessWidget {
  const SettingsInfoRow({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
  });

  final IconData? icon;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: context.themeColors.textMuted, size: 24.r),
          SizedBox(width: 12.w),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                  color: context.themeColors.textPrimary,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 2.w),
                Text(
                  subtitle!,
                  style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                    color: context.themeColors.textMuted,
                  ),
                ),
              ],
            ],
          ),
        ),
        Icon(
          Directionality.of(context) == TextDirection.rtl
              ? Icons.chevron_left
              : Icons.chevron_right,
          color: context.themeColors.textMuted,
          size: 24.r,
        ),
      ],
    );
  }
}
