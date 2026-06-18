import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/profile/data/models/student_course_model.dart';
import 'package:flutter/material.dart';

class ProfileCourseCard extends StatelessWidget {
  const ProfileCourseCard({super.key, required this.course});

  final StudentCourseModel course;

  @override
  Widget build(BuildContext context) {
    final progress = course.progress;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.infoBlue.withValues(alpha: 0.2),
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
                  color: const Color(0xFFDDE8FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.access_time_rounded,
                  color: Color(0xFF5B6EF5),
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
                        color: AppColors.gray600,
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
                      color: AppColors.infoBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${course.displayCreditHours} cr',
                    style: AppTextStyles.poppinsRegular14.copyWith(
                      color: AppColors.gray600,
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
            color: AppColors.gray900,
            backgroundColor: AppColors.gray300,
          ),
        ],
      ),
    );
  }
}
