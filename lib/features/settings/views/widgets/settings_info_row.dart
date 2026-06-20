import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

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
          Icon(icon, color: context.themeColors.textMuted, size: 24),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyInterMedium14.copyWith(
                  color: context.themeColors.textPrimary,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: context.themeColors.textMuted,
                  ),
                ),
              ],
            ],
          ),
        ),
        Icon(Icons.chevron_right, color: context.themeColors.textMuted),
      ],
    );
  }
}
