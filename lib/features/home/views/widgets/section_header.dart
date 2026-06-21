import 'package:edu_advisor/core/theme/app_text_styles.dart';
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
          'Recommended Courses',
          style: AppTextStyles.heading3PoppinsReg16.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
        Text(
          'View All',
          style: AppTextStyles.poppinsRegular14.copyWith(
            color: context.themeColors.info,
          ),
        ),
      ],
    );
  }
}
