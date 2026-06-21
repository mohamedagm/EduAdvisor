import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class RegisterationAlert extends StatelessWidget {
  const RegisterationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.infoContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.themeColors.info.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: context.themeColors.info.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.themeColors.infoContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.calendar_month, color: context.themeColors.info),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.registrationAlert,
                  style: AppTextStyles.heading3PoppinsReg16.copyWith(
                    color: context.themeColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  context.l10n.registrationAlertMessage,
                  style: AppTextStyles.poppinsRegular14.copyWith(
                    color: context.themeColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
