import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class StudentInfo extends StatelessWidget {
  final String fullName;
  final String email;
  final String? imageUrl;

  const StudentInfo({
    super.key,
    required this.fullName,
    required this.email,
    this.imageUrl,
  });

  String get _initials {
    final parts = fullName.trim().split(' ');
    if (parts.isEmpty || parts.first.isEmpty) return '?';
    if (parts.length >= 2 && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundColor: AppColors.gray200,
          backgroundImage: hasImage ? NetworkImage(imageUrl!) : null,
          onBackgroundImageError: hasImage ? (_, __) {} : null,
          child: !hasImage
              ? Text(
                  _initials,
                  style: AppTextStyles.interRegular16.copyWith(
                    color: AppColors.gray600,
                  ),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                fullName,
                style: AppTextStyles.interRegular16.copyWith(
                  color: AppColors.gray600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                email,
                style: AppTextStyles.bodyInterMedium14.copyWith(
                  color: AppColors.gray400,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Student Meta (GPA and Semester)
class StudentMeta extends StatelessWidget {
  final double gpa;
  final int semester;

  const StudentMeta({super.key, required this.gpa, required this.semester});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'GPA: ${gpa.toStringAsFixed(1)}',
          style: AppTextStyles.interRegular16.copyWith(
            color: context.themeColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Semester $semester',
          style: AppTextStyles.bodyInterMedium14.copyWith(
            color: context.themeColors.textMuted,
          ),
        ),
      ],
    );
  }
}
