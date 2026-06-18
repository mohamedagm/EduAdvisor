import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_toggle_row.dart';
import 'package:flutter/material.dart';

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
              const Icon(
                Icons.notifications_none_outlined,
                color: AppColors.purplePrimary,
              ),
              const SizedBox(width: 8),
              Text(
                'Notifications',
                style: AppTextStyles.bodyInterMedium18.copyWith(
                  color: AppColors.gray800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SettingsToggleRow(
            title: 'Push Notifications',
            subtitle: 'Receive push notifications',
            isOn: pushNotifications,
            onChanged: onPushNotificationsChanged,
          ),
          const SizedBox(height: 20),
          SettingsToggleRow(
            title: 'Email Notifications',
            subtitle: 'Receive email updates',
            isOn: emailNotifications,
            onChanged: onEmailNotificationsChanged,
          ),
          const SizedBox(height: 20),
          SettingsToggleRow(
            title: 'Grade Alerts',
            subtitle: 'Notify when grades are posted',
            isOn: gradeAlerts,
            onChanged: onGradeAlertsChanged,
          ),
        ],
      ),
    );
  }
}
