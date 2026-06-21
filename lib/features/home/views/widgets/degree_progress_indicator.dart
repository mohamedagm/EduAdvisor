import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class DegreeProgressIndicator extends StatelessWidget {
  const DegreeProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.themeColors.border.withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.degreeProgress,
                    style: AppTextStyles.heading3PoppinsReg16.copyWith(
                      color: context.themeColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    context.l10n.degreeProgramName,
                    style: AppTextStyles.poppinsRegular14.copyWith(
                      color: context.themeColors.textSecondary,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    context.l10n.creditsRatio('65', '140'),
                    style: AppTextStyles.interRegular16.copyWith(
                      color: context.themeColors.info,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    context.l10n.creditsLabel,
                    style: AppTextStyles.interRegular16.copyWith(
                      color: context.themeColors.info,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(16),
            value: 65 / 140,
            minHeight: 10,
            backgroundColor: context.themeColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(
              context.themeColors.textPrimary,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            context.l10n.onTrackToGraduate(context.l10n.spring2026),
            style: AppTextStyles.poppinsRegular14.copyWith(
              color: context.themeColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
