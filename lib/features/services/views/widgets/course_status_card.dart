import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

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
        color: AppColors.yellowLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.warningAmber),
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
                      color: AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$minCredits - $maxCredits hours required',
                    style: AppTextStyles.bodyInterRegular12.copyWith(
                      color: AppColors.gray500,
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
                        color: AppColors.warningAmberDark,
                      ),
                    ),
                    TextSpan(
                      text: ' / $maxCredits',
                      style: AppTextStyles.interRegular16.copyWith(
                        color: AppColors.gray500,
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
                const Icon(
                  Icons.error_outline,
                  color: AppColors.warningAmberDark,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Add $creditsNeeded more credit hours',
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: AppColors.warningAmberDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: AppColors.successGreenDark,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Minimum credit requirement met',
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: AppColors.successGreenDark,
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
