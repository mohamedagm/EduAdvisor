import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class SettingsSecuritySection extends StatelessWidget {
  const SettingsSecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lock_outline, color: context.colorScheme.error),
              const SizedBox(width: 8),
              Text(
                'Security',
                style: AppTextStyles.bodyInterMedium18.copyWith(
                  color: context.themeColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const SettingsInfoRow(title: 'Change Password'),
        ],
      ),
    );
  }
}
