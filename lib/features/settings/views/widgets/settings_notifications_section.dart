import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_toggle_row.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

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
                color: context.colorScheme.secondary,
              ),
              const SizedBox(width: 8),
              Text(
                context.l10n.notifications,
                style: AppTextStyles.bodyInterMedium18.copyWith(
                  color: context.themeColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsToggleRow(
            title: context.l10n.pushNotifications,
            subtitle: context.l10n.receivePushNotifications,
            isOn: pushNotifications,
            onChanged: onPushNotificationsChanged,
          ),
          const SizedBox(height: 20),
          SettingsToggleRow(
            title: context.l10n.emailNotifications,
            subtitle: context.l10n.receiveEmailUpdates,
            isOn: emailNotifications,
            onChanged: onEmailNotificationsChanged,
          ),
          const SizedBox(height: 20),
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
