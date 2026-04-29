import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'widgets/service_app_bar.dart';

class CourseRecommendationsView extends StatelessWidget {
  const CourseRecommendationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ServiceAppBar(
        title: 'Course Recommendations',
        subtitle: 'AI-powered suggestions for you',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.blueLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
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
                          'Personalized for You',
                          style: AppTextStyles.heading3PoppinsReg16.copyWith(
                            color: AppColors.gray900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Based on your academic profile',
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: AppColors.gray500,
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
              iconData: Icons.smart_toy_outlined,
              iconBgColor: AppColors.aiPurple,
              courseCode: 'CS 301',
              courseName: 'Machine Learning',
              matchScore: '95',
              credits: '3 Credits',
              difficulty: 'Hard',
              reason:
                  'Strong performance in Data Structures. High demand field.',
              benefits: [
                'Aligns with your strengths in programming',
                'High job market demand',
                'Can improve GPA by +0.4',
              ],
            ),
            const SizedBox(height: 16),
            _buildRecommendationCard(
              iconData: Icons.architecture,
              iconBgColor: const Color(0xFFF97316),
              courseCode: 'MATH 301',
              courseName: 'Advanced Linear Algebra',
              matchScore: '78',
              credits: '4 Credits',
              difficulty: 'Hard',
              reason: 'Strong foundation for AI/ML specialization.',
              benefits: [
                'Essential for ML/AI track',
                'Strong math background advantage',
                'Research opportunities',
              ],
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.blueLight,
                border: Border.all(
                  color: AppColors.bluePrimary.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.workspace_premium_outlined,
                    color: AppColors.bluePrimary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recommendations updated daily',
                          style: AppTextStyles.interRegular16.copyWith(
                            color: AppColors.gray900,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Our AI analyzes your performance, prerequisites, and career goals to suggest the best courses.',
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: AppColors.gray600,
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
    required IconData iconData,
    required Color iconBgColor,
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
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
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
                child: Icon(iconData, color: AppColors.white, size: 28),
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
                            color: AppColors.gray900,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.purpleLight,
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
                        color: AppColors.gray500,
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
                text: credits,
                textColor: AppColors.gray900,
                borderColor: AppColors.gray300,
              ),
              const SizedBox(width: 8),
              _buildSmallBadge(
                text: difficulty,
                textColor: AppColors.errorRed,
                borderColor: AppColors.errorRed.withValues(alpha: 0.4),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              reason,
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: AppColors.gray700,
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
                    const Icon(
                      Icons.trending_up,
                      color: AppColors.successGreenDark,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        benefit,
                        style: AppTextStyles.bodyInterRegular12.copyWith(
                          color: AppColors.gray600,
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
    required String text,
    required Color textColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
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
