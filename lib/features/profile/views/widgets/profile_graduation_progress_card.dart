import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class ProfileGraduationProgressCard extends StatelessWidget {
  const ProfileGraduationProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: context.themeColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: context.themeColors.border, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Progress to Graduation",
              style: AppTextStyles.heading2PoppinsSb18,
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Credits Completed",
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: context.themeColors.textSecondary,
                  ),
                ),
                Text("65/140", style: AppTextStyles.bodyInterMedium14),
              ],
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              color: context.themeColors.textPrimary,
              backgroundColor: context.colorScheme.outline,
              minHeight: 12,
              value: 65 / 140,
              borderRadius: BorderRadius.circular(10),
            ),

            const SizedBox(height: 8),

            Text(
              "75 credits remaining",
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
