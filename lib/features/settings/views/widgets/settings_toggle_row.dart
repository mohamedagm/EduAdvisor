import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

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
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.bodyInterRegular12.copyWith(
                  color: context.themeColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => onChanged(!isOn),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isOn
                  ? context.themeColors.successContainer
                  : context.themeColors.border,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              isOn ? context.l10n.settingOn : context.l10n.settingOff,
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: isOn
                    ? context.themeColors.success
                    : context.themeColors.textMuted,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
