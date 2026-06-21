import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'widgets/service_app_bar.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.themeColors.infoContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: context.themeColors.card,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.aiPurple,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.personalizedForYou,
                          style: AppTextStyles.heading3PoppinsReg16.copyWith(
                            color: context.themeColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          context.l10n.basedOnAcademicProfile,
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: context.themeColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.themeColors.infoContainer,
                border: Border.all(
                  color: context.colorScheme.primary.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.workspace_premium_outlined,
                    color: context.colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.recommendationsUpdatedDaily,
                          style: AppTextStyles.interRegular16.copyWith(
                            color: context.themeColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          context.l10n.recommendationsAiDescription,
                          style: AppTextStyles.bodyInterRegular12.copyWith(
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
            const SizedBox(height: 24),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(iconData, color: iconForegroundColor, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          courseCode,
                          style: AppTextStyles.heading1_20b.copyWith(
                            fontSize: 18,
                            color: context.themeColors.textPrimary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: context.themeColors.purpleContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_border,
                                color: AppColors.aiPurple,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                matchScore,
                                style: AppTextStyles.bodyInterMedium14.copyWith(
                                  color: AppColors.aiPurple,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      courseName,
                      style: AppTextStyles.poppinsRegular14.copyWith(
                        color: context.themeColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              _buildSmallBadge(
                context: context,
                text: credits,
                textColor: context.themeColors.textPrimary,
                borderColor: context.colorScheme.outline,
              ),
              const SizedBox(width: 8),
              _buildSmallBadge(
                context: context,
                text: difficulty,
                textColor: context.colorScheme.error,
                borderColor: context.colorScheme.error.withValues(alpha: 0.4),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              reason,
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: context.themeColors.textSecondary,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 16),

          Column(
            children: benefits.map((benefit) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.trending_up,
                      color: context.themeColors.success,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        benefit,
                        style: AppTextStyles.bodyInterRegular12.copyWith(
                          color: context.themeColors.textSecondary,
                          fontSize: 13,
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyInterRegular12.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
