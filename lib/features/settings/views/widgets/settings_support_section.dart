import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsSupportSection extends StatelessWidget {
  const SettingsSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.support,
            style: AppTextStyles.bodyInterMedium18.responsive.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
          SizedBox(height: 16.w),
          SettingsInfoRow(
            icon: Icons.help_outline,
            title: context.l10n.helpCenter,
          ),
          SizedBox(height: 16.w),
          SettingsInfoRow(
            icon: Icons.info_outline,
            title: context.l10n.aboutEduAdvisor,
          ),
        ],
      ),
    );
  }
}
