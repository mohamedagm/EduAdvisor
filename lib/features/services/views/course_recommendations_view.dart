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
    final recommendations = _recommendations(context);

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
            for (var index = 0; index < recommendations.length; index++) ...[
              _buildRecommendationCard(
                context: context,
                recommendation: recommendations[index],
              ),
              if (index != recommendations.length - 1) SizedBox(height: 16.w),
            ],
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
    required _RecommendationData recommendation,
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
                  color: recommendation.iconBgColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  recommendation.iconData,
                  color: recommendation.iconForegroundColor,
                  size: 28.r,
                ),
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
                            recommendation.courseCode,
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
                                '${recommendation.matchScore}%',
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
                      recommendation.courseName,
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
                text: recommendation.credits,
                textColor: context.themeColors.textPrimary,
                borderColor: context.colorScheme.outline,
              ),
              _buildSmallBadge(
                context: context,
                text: recommendation.difficulty,
                textColor: recommendation.difficultyColor,
                borderColor: recommendation.difficultyColor.withValues(
                  alpha: 0.4,
                ),
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
              recommendation.reason,
              style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                color: context.themeColors.textSecondary,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(height: 16.w),

          Column(
            children: recommendation.benefits.map((benefit) {
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

  List<_RecommendationData> _recommendations(BuildContext context) {
    return [
      _RecommendationData(
        iconData: Icons.smart_toy_outlined,
        iconBgColor: AppColors.aiPurple,
        iconForegroundColor: AppColors.white,
        courseCode: 'CS 301',
        courseName: context.l10n.machineLearning,
        matchScore: 95,
        credits: context.l10n.courseCredits('3'),
        difficulty: context.l10n.hardDifficulty,
        difficultyColor: context.colorScheme.error,
        reason: context.l10n.machineLearningRecommendationReason,
        benefits: [
          context.l10n.programmingStrengthBenefit,
          context.l10n.jobMarketDemandBenefit,
          context.l10n.gpaImprovementBenefit,
        ],
      ),
      _RecommendationData(
        iconData: Icons.cloud_outlined,
        iconBgColor: context.themeColors.info,
        iconForegroundColor: context.themeColors.onInfo,
        courseCode: 'CS 315',
        courseName: context.l10n.cloudComputing,
        matchScore: 91,
        credits: context.l10n.courseCredits('3'),
        difficulty: context.l10n.mediumDifficulty,
        difficultyColor: context.themeColors.warning,
        reason: context.l10n.cloudComputingRecommendationReason,
        benefits: [
          context.l10n.networkingFoundationBenefit,
          context.l10n.cloudSkillsBenefit,
          context.l10n.cloudCareerBenefit,
        ],
      ),
      _RecommendationData(
        iconData: Icons.phone_android_outlined,
        iconBgColor: context.themeColors.success,
        iconForegroundColor: context.themeColors.onSuccess,
        courseCode: 'CS 322',
        courseName: context.l10n.mobileApplicationDevelopment,
        matchScore: 88,
        credits: context.l10n.courseCredits('3'),
        difficulty: context.l10n.mediumDifficulty,
        difficultyColor: context.themeColors.warning,
        reason: context.l10n.mobileDevelopmentRecommendationReason,
        benefits: [
          context.l10n.portfolioProjectBenefit,
          context.l10n.mobileCareerBenefit,
          context.l10n.teamworkExperienceBenefit,
        ],
      ),
      _RecommendationData(
        iconData: Icons.security_outlined,
        iconBgColor: AppColors.aiPink,
        iconForegroundColor: AppColors.white,
        courseCode: 'CS 340',
        courseName: context.l10n.cybersecurityFundamentals,
        matchScore: 85,
        credits: context.l10n.courseCredits('3'),
        difficulty: context.l10n.mediumDifficulty,
        difficultyColor: context.themeColors.warning,
        reason: context.l10n.cybersecurityRecommendationReason,
        benefits: [
          context.l10n.cybersecurityDemandBenefit,
          context.l10n.securityTrackBenefit,
          context.l10n.riskAssessmentBenefit,
        ],
      ),
      _RecommendationData(
        iconData: Icons.query_stats_outlined,
        iconBgColor: context.themeColors.warning,
        iconForegroundColor: context.themeColors.onWarning,
        courseCode: 'STAT 310',
        courseName: context.l10n.appliedStatistics,
        matchScore: 82,
        credits: context.l10n.courseCredits('3'),
        difficulty: context.l10n.mediumDifficulty,
        difficultyColor: context.themeColors.warning,
        reason: context.l10n.statisticsRecommendationReason,
        benefits: [
          context.l10n.dataInterpretationBenefit,
          context.l10n.dataSciencePrerequisiteBenefit,
          context.l10n.graduationProjectBenefit,
        ],
      ),
      _RecommendationData(
        iconData: Icons.architecture,
        iconBgColor: context.themeColors.warning,
        iconForegroundColor: context.themeColors.onWarning,
        courseCode: 'MATH 301',
        courseName: context.l10n.advancedLinearAlgebra,
        matchScore: 78,
        credits: context.l10n.courseCredits('4'),
        difficulty: context.l10n.hardDifficulty,
        difficultyColor: context.colorScheme.error,
        reason: context.l10n.linearAlgebraRecommendationReason,
        benefits: [
          context.l10n.mlTrackBenefit,
          context.l10n.mathBackgroundBenefit,
          context.l10n.researchOpportunitiesBenefit,
        ],
      ),
    ];
  }
}

class _RecommendationData {
  const _RecommendationData({
    required this.iconData,
    required this.iconBgColor,
    required this.iconForegroundColor,
    required this.courseCode,
    required this.courseName,
    required this.matchScore,
    required this.credits,
    required this.difficulty,
    required this.difficultyColor,
    required this.reason,
    required this.benefits,
  });

  final IconData iconData;
  final Color iconBgColor;
  final Color iconForegroundColor;
  final String courseCode;
  final String courseName;
  final int matchScore;
  final String credits;
  final String difficulty;
  final Color difficultyColor;
  final String reason;
  final List<String> benefits;
}
