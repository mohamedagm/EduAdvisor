import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

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
          Icon(icon, color: AppColors.gray500, size: 24),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyInterMedium14.copyWith(
                  color: AppColors.gray900,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: AppColors.gray500,
                  ),
                ),
              ],
            ],
          ),
        ),
        const Icon(Icons.chevron_right, color: AppColors.gray400),
      ],
    );
  }
}
