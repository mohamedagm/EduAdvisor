import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/profile/data/models/student_course_model.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class ProfileCourseCard extends StatelessWidget {
  const ProfileCourseCard({super.key, required this.course});

  final StudentCourseModel course;

  @override
  Widget build(BuildContext context) {
    final progress = course.progress;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.themeColors.infoContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: context.themeColors.info.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: context.themeColors.info.withValues(alpha: 0.16),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.access_time_rounded,
                  color: context.themeColors.info,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.displayCode,
                      style: AppTextStyles.heading3PoppinsReg16,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      course.displayName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.poppinsRegular14.copyWith(
                        color: context.themeColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: AppTextStyles.interRegular16.copyWith(
                      color: context.themeColors.info,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${course.displayCreditHours} cr',
                    style: AppTextStyles.poppinsRegular14.copyWith(
                      color: context.themeColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(10),
            value: progress,
            minHeight: 8,
            color: context.themeColors.textPrimary,
            backgroundColor: context.colorScheme.outline,
          ),
        ],
      ),
    );
  }
}
