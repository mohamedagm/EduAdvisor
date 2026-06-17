import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_gradiants.dart';
import '../../../core/theme/app_text_styles.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool gradeAlerts = true;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppGradients.primary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Settings',
          style: AppTextStyles.heading1_20b.copyWith(color: AppColors.white),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileSection(),
            const SizedBox(height: 16),
            _buildNotificationsSection(),
            const SizedBox(height: 16),
            _buildPreferencesSection(),
            const SizedBox(height: 16),
            _buildSecuritySection(),
            const SizedBox(height: 16),
            _buildSupportSection(),
            const SizedBox(height: 16),
            _buildLogOutSection(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
      ),
      child: child,
    );
  }

  Widget _buildProfileSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.person_outline, color: AppColors.bluePrimary),
              const SizedBox(width: 8),
              Text(
                'Profile Information',
                style: AppTextStyles.bodyInterMedium18.copyWith(
                  color: AppColors.gray800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gray200),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.gray200,
                  child: Icon(Icons.person, color: AppColors.gray500),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ALiaa Mohamed',
                        style: AppTextStyles.bodyInterMedium14.copyWith(
                          color: AppColors.gray900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'am9177@fayoum.edu.eg',
                        style: AppTextStyles.bodyInterRegular12.copyWith(
                          color: AppColors.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.gray400),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.mail_outline,
            title: 'Email',
            subtitle: 'am9177@fayoum.edu.eg',
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            icon: Icons.smartphone_outlined,
            title: 'Phone Number',
            subtitle: 'Not set',
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return _buildCard(
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
          _buildToggleRow(
            title: 'Push Notifications',
            subtitle: 'Receive push notifications',
            isOn: pushNotifications,
            onChanged: (val) => setState(() => pushNotifications = val),
          ),
          const SizedBox(height: 20),
          _buildToggleRow(
            title: 'Email Notifications',
            subtitle: 'Receive email updates',
            isOn: emailNotifications,
            onChanged: (val) => setState(() => emailNotifications = val),
          ),
          const SizedBox(height: 20),
          _buildToggleRow(
            title: 'Grade Alerts',
            subtitle: 'Notify when grades are posted',
            isOn: gradeAlerts,
            onChanged: (val) => setState(() => gradeAlerts = val),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return _buildCard(
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
          _buildInfoRow(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English',
          ),
          const SizedBox(height: 20),
          _buildToggleRow(
            icon: Icons.dark_mode_outlined,
            title: 'Dark Mode',
            subtitle: 'Use dark theme',
            isOn: darkMode,
            onChanged: (val) => setState(() => darkMode = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.lock_outline, color: AppColors.errorRed),
              const SizedBox(width: 8),
              Text(
                'Security',
                style: AppTextStyles.bodyInterMedium18.copyWith(
                  color: AppColors.gray800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(title: 'Change Password'),
        ],
      ),
    );
  }

  Widget _buildSupportSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Support',
            style: AppTextStyles.bodyInterMedium18.copyWith(
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(icon: Icons.help_outline, title: 'Help Center'),
          const SizedBox(height: 16),
          _buildInfoRow(icon: Icons.info_outline, title: 'About EduAdvisor'),
        ],
      ),
    );
  }

  Widget _buildLogOutSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.errorRed.withValues(alpha: 0.2)),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.errorRed.withValues(alpha: 0.4)),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout, color: AppColors.errorRed),
            const SizedBox(width: 8),
            Text(
              'Log Out',
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: AppColors.errorRed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    IconData? icon,
    required String title,
    String? subtitle,
  }) {
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
                  subtitle,
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

  Widget _buildToggleRow({
    IconData? icon,
    required String title,
    required String subtitle,
    required bool isOn,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: AppTextStyles.bodyInterRegular12.copyWith(
                  color: AppColors.gray500,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            onChanged(!isOn);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isOn ? AppColors.greenLight : AppColors.gray200,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              isOn ? 'On' : 'Off',
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: isOn ? AppColors.successGreenDark : AppColors.gray500,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
