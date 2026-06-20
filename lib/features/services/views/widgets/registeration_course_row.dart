import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class RegistrationCourseRow extends StatelessWidget {
  final String code;
  final String name;
  final String credits;

  const RegistrationCourseRow({
    super.key,
    required this.code,
    required this.name,
    required this.credits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_outlined,
            color: context.colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: context.themeColors.textPrimary,
                  ),
                ),
                if (name.isNotEmpty)
                  Text(
                    name,
                    style: AppTextStyles.bodyInterRegular12.copyWith(
                      color: context.themeColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: context.themeColors.card,
              border: Border.all(color: context.themeColors.border),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              credits,
              style: AppTextStyles.bodyInterRegular12.copyWith(
                color: context.themeColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
