import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class RegistrationSummaryBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String count;
  final String label;

  const RegistrationSummaryBox({
    super.key,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: color.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              count,
              style: AppTextStyles.heading1_20b.copyWith(
                fontSize: 24,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.bodyInterRegular12.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
