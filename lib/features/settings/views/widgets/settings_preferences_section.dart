import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_toggle_row.dart';
import 'package:flutter/material.dart';

class SettingsPreferencesSection extends StatelessWidget {
  const SettingsPreferencesSection({
    super.key,
    required this.darkMode,
    required this.onDarkModeChanged,
  });

  final bool darkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferences',
            style: AppTextStyles.bodyInterMedium18.copyWith(
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 16),
          const SettingsInfoRow(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English',
          ),
          const SizedBox(height: 20),
          SettingsToggleRow(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Use dark theme',
            isOn: darkMode,
            onChanged: onDarkModeChanged,
          ),
        ],
      ),
    );
  }
}
