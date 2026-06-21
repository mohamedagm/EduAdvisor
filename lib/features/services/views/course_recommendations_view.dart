import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/app_screen_util.dart';
import 'widgets/service_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseRecommendationsView extends StatelessWidget {
  const CourseRecommendationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ServiceAppBar(
        title: context.l10n.courseRecommendationsTitle,
        subtitle: context.l10n.aiPoweredSuggestionsForYou,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: context.themeColors.infoContainer,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: context.themeColors.card,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.auto_awesome,
                      color: AppColors.aiPurple,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.personalizedForYou,
                          style: AppTextStyles.heading3PoppinsReg16.responsive
                              .copyWith(
                                color: context.themeColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 2.w),
                        Text(
                          context.l10n.basedOnAcademicProfile,
                          style: AppTextStyles.bodyInterRegular12.responsive
                              .copyWith(color: context.themeColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.w),
            _buildRecommendationCard(
              context: context,
              iconData: Icons.smart_toy_outlined,
              iconBgColor: AppColors.aiPurple,
              iconForegroundColor: AppColors.white,
              courseCode: 'CS 301',
              courseName: context.l10n.machineLearning,
              matchScore: '95',
              credits: context.l10n.courseCredits('3'),
              difficulty: context.l10n.hardDifficulty,
              reason: context.l10n.machineLearningRecommendationReason,
              benefits: [
                context.l10n.programmingStrengthBenefit,
                context.l10n.jobMarketDemandBenefit,
                context.l10n.gpaImprovementBenefit,
              ],
            ),
            SizedBox(height: 16.w),
            _buildRecommendationCard(
              context: context,
              iconData: Icons.architecture,
              iconBgColor: context.themeColors.warning,
              iconForegroundColor: context.themeColors.onWarning,
              courseCode: 'MATH 301',
              courseName: context.l10n.advancedLinearAlgebra,
              matchScore: '78',
              credits: context.l10n.courseCredits('4'),
              difficulty: context.l10n.hardDifficulty,
              reason: context.l10n.linearAlgebraRecommendationReason,
              benefits: [
                context.l10n.mlTrackBenefit,
                context.l10n.mathBackgroundBenefit,
                context.l10n.researchOpportunitiesBenefit,
              ],
            ),
            SizedBox(height: 24.w),

            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: context.themeColors.infoContainer,
                border: Border.all(
                  color: context.colorScheme.primary.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.workspace_premium_outlined,
                    color: context.colorScheme.primary,
                    size: 24.r,
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.recommendationsUpdatedDaily,
                          style: AppTextStyles.interRegular16.responsive
                              .copyWith(
                                color: context.themeColors.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          context.l10n.recommendationsAiDescription,
                          style: AppTextStyles.bodyInterRegular12.responsive
                              .copyWith(
                                color: context.themeColors.textSecondary,
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.w),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard({
    required BuildContext context,
    required IconData iconData,
    required Color iconBgColor,
    required Color iconForegroundColor,
    required String courseCode,
    required String courseName,
    required String matchScore,
    required String credits,
    required String difficulty,
    required String reason,
    required List<String> benefits,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.r,
                height: 48.r,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(iconData, color: iconForegroundColor, size: 28.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            courseCode,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.heading1_20b.copyWith(
                              fontSize: 18.sp,
                              color: context.themeColors.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: context.themeColors.purpleContainer,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_border,
                                color: AppColors.aiPurple,
                                size: 16.r,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                matchScore,
                                style: AppTextStyles
                                    .bodyInterMedium14
                                    .responsive
                                    .copyWith(color: AppColors.aiPurple),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      courseName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                        color: context.themeColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),

          Wrap(
            spacing: 8.w,
            runSpacing: 8.w,
            children: [
              _buildSmallBadge(
                context: context,
                text: credits,
                textColor: context.themeColors.textPrimary,
                borderColor: context.colorScheme.outline,
              ),
              _buildSmallBadge(
                context: context,
                text: difficulty,
                textColor: context.colorScheme.error,
                borderColor: context.colorScheme.error.withValues(alpha: 0.4),
              ),
            ],
          ),
          SizedBox(height: 16.w),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              reason,
              style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                color: context.themeColors.textSecondary,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 16.w),

          Column(
            children: benefits.map((benefit) {
              return Padding(
                padding: EdgeInsets.only(bottom: 8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: context.themeColors.success,
                      size: 18.r,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        benefit,
                        style: AppTextStyles.bodyInterRegular12.copyWith(
                          color: context.themeColors.textSecondary,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallBadge({
    required BuildContext context,
    required String text,
    required Color textColor,
    required Color borderColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
