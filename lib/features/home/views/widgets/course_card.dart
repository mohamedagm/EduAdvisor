import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class CourseCard extends StatelessWidget {
  final String imageUrl;
  final String code;
  final String title;
  final String progressPercentage;
  final String credits;

  const CourseCard({
    super.key,
    required this.imageUrl,
    required this.code,
    required this.title,
    required this.progressPercentage,
    required this.credits,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: AppShimmerNetworkImage(
                    imageUrl: imageUrl,
                    errorWidget: ColoredBox(
                      color: context.themeColors.mutedSurface,
                      child: Center(child: Icon(Icons.school_outlined)),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border_rounded,
                        size: 13,
                        color: context.colorScheme.secondary,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        progressPercentage,
                        style: AppTextStyles.bodyInterMedium14.copyWith(
                          color: context.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(code, style: AppTextStyles.poppinsRegular14),
                Text(
                  title,
                  style: AppTextStyles.interRegular16.copyWith(
                    color: context.themeColors.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: context.themeColors.card,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: context.themeColors.border),
                      ),
                      child: Text(
                        credits,
                        style: AppTextStyles.interRegular16.copyWith(
                          color: context.themeColors.textPrimary,
                        ),
                      ),
                    ),

                    Icon(
                      Icons.chevron_right_rounded,
                      size: 22,
                      color: context.themeColors.textSecondary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
