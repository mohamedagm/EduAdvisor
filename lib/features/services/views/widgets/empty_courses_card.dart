import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class EmptyCoursesCard extends StatelessWidget {
  const EmptyCoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: context.themeColors.mutedSurface,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              color: context.themeColors.textMuted,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No courses selected',
            style: AppTextStyles.heading3PoppinsReg16.copyWith(
              color: context.themeColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Click "Add Course" to start',
            style: AppTextStyles.poppinsRegular14.copyWith(
              color: context.themeColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
