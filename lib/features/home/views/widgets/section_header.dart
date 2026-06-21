import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.l10n.recommendedCourses,
          style: AppTextStyles.heading3PoppinsReg16.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
        Text(
          context.l10n.viewAll,
          style: AppTextStyles.poppinsRegular14.copyWith(
            color: context.themeColors.info,
          ),
        ),
      ],
    );
  }
}
