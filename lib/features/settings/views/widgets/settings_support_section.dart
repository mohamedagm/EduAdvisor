import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class SettingsSupportSection extends StatelessWidget {
  const SettingsSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Support',
            style: AppTextStyles.bodyInterMedium18.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          const SettingsInfoRow(icon: Icons.help_outline, title: 'Help Center'),
          const SizedBox(height: 16),
          const SettingsInfoRow(
            icon: Icons.info_outline,
            title: 'About EduAdvisor',
          ),
        ],
      ),
    );
  }
}
