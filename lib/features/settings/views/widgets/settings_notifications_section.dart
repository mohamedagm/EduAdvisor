import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_toggle_row.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsNotificationsSection extends StatelessWidget {
  const SettingsNotificationsSection({
    super.key,
    required this.pushNotifications,
    required this.emailNotifications,
    required this.gradeAlerts,
    required this.onPushNotificationsChanged,
    required this.onEmailNotificationsChanged,
    required this.onGradeAlertsChanged,
  });

  final bool pushNotifications;
  final bool emailNotifications;
  final bool gradeAlerts;
  final ValueChanged<bool> onPushNotificationsChanged;
  final ValueChanged<bool> onEmailNotificationsChanged;
  final ValueChanged<bool> onGradeAlertsChanged;

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_none_outlined,
                size: 24.r,
                color: context.colorScheme.secondary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  context.l10n.notifications,
                  style: AppTextStyles.bodyInterMedium18.responsive.copyWith(
                    color: context.themeColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          SettingsToggleRow(
            title: context.l10n.pushNotifications,
            subtitle: context.l10n.receivePushNotifications,
            isOn: pushNotifications,
            onChanged: onPushNotificationsChanged,
          ),
          SizedBox(height: 20.w),
          SettingsToggleRow(
            title: context.l10n.emailNotifications,
            subtitle: context.l10n.receiveEmailUpdates,
            isOn: emailNotifications,
            onChanged: onEmailNotificationsChanged,
          ),
          SizedBox(height: 20.w),
          SettingsToggleRow(
            title: context.l10n.gradeAlerts,
            subtitle: context.l10n.notifyWhenGradesPosted,
            isOn: gradeAlerts,
            onChanged: onGradeAlertsChanged,
          ),
        ],
      ),
    );
  }
}
