import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_logout_section.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_preferences_section.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_profile_section.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_security_section.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_support_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/Manager/cubit/auth_cubit.dart';
import 'settings_notifications_section.dart';

class SettingsViewBody extends StatefulWidget {
  const SettingsViewBody({super.key});

  @override
  State<SettingsViewBody> createState() => _SettingsViewBodyState();
}

class _SettingsViewBodyState extends State<SettingsViewBody> {
  bool pushNotifications = true;
  bool emailNotifications = true;
  bool gradeAlerts = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: _handleAuthState,
      builder: (context, state) {
        final isLoggingOut = state is LogoutLoading;

        return Scaffold(
          backgroundColor: context.colorScheme.surface,
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(gradient: AppGradients.primary),
            ),
            leading: BackButton(
              color: AppColors.white,
              onPressed: isLoggingOut ? null : () => context.pop(),
            ),
            title: Text(
              context.l10n.settingsTitle,
              style: AppTextStyles.heading1_20b.responsive.copyWith(
                color: AppColors.white,
              ),
            ),
            centerTitle: false,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SettingsProfileSection(),
                SizedBox(height: 16.w),
                SettingsNotificationsSection(
                  pushNotifications: pushNotifications,
                  emailNotifications: emailNotifications,
                  gradeAlerts: gradeAlerts,
                  onPushNotificationsChanged: (value) {
                    setState(() => pushNotifications = value);
                  },
                  onEmailNotificationsChanged: (value) {
                    setState(() => emailNotifications = value);
                  },
                  onGradeAlertsChanged: (value) {
                    setState(() => gradeAlerts = value);
                  },
                ),
                SizedBox(height: 16.w),
                const SettingsPreferencesSection(),
                SizedBox(height: 16.w),
                const SettingsSecuritySection(),
                SizedBox(height: 16.w),
                const SettingsSupportSection(),
                SizedBox(height: 16.w),
                SettingsLogoutSection(isLoggingOut: isLoggingOut),
                SizedBox(height: 32.w),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is LogoutSuccess) {
      AppToast.success(
        context,
        title: context.l10n.loggedOut,
        description: context.l10n.loggedOutDescription,
      );
      context.go(AppRoutes.chooseUserRole);
    }

    if (state is LogoutFailure) {
      AppToast.error(
        context,
        title: context.l10n.loggedOutLocally,
        description: context.l10n.loggedOutLocallyDescription,
      );
      context.go(AppRoutes.chooseUserRole);
    }
  }
}
