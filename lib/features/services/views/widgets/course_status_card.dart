import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class CourseStatusCard extends StatelessWidget {
  final int currentCredits;
  final int minCredits;
  final int maxCredits;

  const CourseStatusCard({
    super.key,
    required this.currentCredits,
    this.minCredits = 12,
    this.maxCredits = 18,
  });

  @override
  Widget build(BuildContext context) {
    final int creditsNeeded = minCredits - currentCredits;
    final bool hasEnoughCredits = creditsNeeded <= 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.warningContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.themeColors.warning),
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
                    'Total Credit Hours',
                    style: AppTextStyles.interRegular16.copyWith(
                      color: context.themeColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$minCredits - $maxCredits hours required',
                    style: AppTextStyles.bodyInterRegular12.copyWith(
                      color: context.themeColors.textMuted,
                    ),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$currentCredits',
                      style: AppTextStyles.heading1_20b.copyWith(
                        fontSize: 28,
                        color: context.themeColors.warning,
                      ),
                    ),
                    TextSpan(
                      text: ' / $maxCredits',
                      style: AppTextStyles.interRegular16.copyWith(
                        color: context.themeColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!hasEnoughCredits) ...[
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: context.themeColors.warning,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Add $creditsNeeded more credit hours',
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: context.themeColors.warning,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: context.themeColors.success,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Minimum credit requirement met',
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: context.themeColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
