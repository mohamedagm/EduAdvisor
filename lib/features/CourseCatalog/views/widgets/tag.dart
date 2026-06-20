import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class Tag extends StatelessWidget {
  final String label;
  const Tag({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: context.themeColors.mutedSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodyInterRegular12.copyWith(
          color: context.themeColors.textPrimary,
        ),
      ),
    );
  }
}
