import 'package:flutter/material.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.warningContainer,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.warning),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.totalCreditHours,
                      style: AppTextStyles.interRegular16.responsive.copyWith(
                        color: context.themeColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      context.l10n.creditHoursRequired(minCredits, maxCredits),
                      style: AppTextStyles.bodyInterRegular12.responsive
                          .copyWith(color: context.themeColors.textMuted),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$currentCredits',
                      style: AppTextStyles.heading1_20b.copyWith(
                        fontSize: 28.sp,
                        color: context.themeColors.warning,
                      ),
                    ),
                    TextSpan(
                      text: ' / $maxCredits',
                      style: AppTextStyles.interRegular16.responsive.copyWith(
                        color: context.themeColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.w),
          if (!hasEnoughCredits) ...[
            Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: context.themeColors.warning,
                  size: 16.r,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    context.l10n.addMoreCreditHours(creditsNeeded),
                    style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                      color: context.themeColors.warning,
                      fontWeight: FontWeight.w500,
                    ),
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
                  size: 16.r,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    context.l10n.minimumCreditRequirementMet,
                    style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                      color: context.themeColors.success,
                      fontWeight: FontWeight.w500,
                    ),
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
