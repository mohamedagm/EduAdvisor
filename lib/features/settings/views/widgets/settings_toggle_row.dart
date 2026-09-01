import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsToggleRow extends StatelessWidget {
  const SettingsToggleRow({
    super.key,
    this.icon,
    required this.title,
    required this.subtitle,
    required this.isOn,
    required this.onChanged,
  });

  final IconData? icon;
  final String title;
  final String subtitle;
  final bool isOn;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              SizedBox(height: 2.w),
              Text(
                subtitle,
                style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                  color: context.themeColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Switch.adaptive(
          value: isOn,
          onChanged: onChanged,
          activeTrackColor: context.colorScheme.primary,
          thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white;
            }
            return context.themeColors.textMuted;
          }),
          trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
        ),
      ],
    );
  }
}
