import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class StudentInfoCard extends StatelessWidget {
  final String studentName;
  final String studentCode;
  final String department;
  final int academicYear;
  final String? photoUrl;

  const StudentInfoCard({
    super.key,
    required this.studentName,
    required this.studentCode,
    required this.department,
    required this.academicYear,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoUrl != null && photoUrl!.trim().isNotEmpty;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.themeColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 10.r,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: context.themeColors.mutedSurface,
                backgroundImage: hasPhoto ? NetworkImage(photoUrl!) : null,
                onBackgroundImageError: hasPhoto ? (_, __) {} : null,
                child: !hasPhoto
                    ? Icon(
                        Icons.person,
                        size: 30.r,
                        color: context.themeColors.textMuted,
                      )
                    : null,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentName,
                      style: AppTextStyles.heading1_20b.copyWith(
                        fontSize: 18.sp,
                        color: context.themeColors.textPrimary,
                      ),
                    ),
                    Text(
                      "$department • ID: $studentCode",
                      style: AppTextStyles.bodyInterMedium14.copyWith(
                        color: context.themeColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 4.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 4.w,
                      ),
                      decoration: BoxDecoration(
                        color: context.themeColors.infoContainer,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        "Year $academicYear",
                        style: AppTextStyles.bodyInterMedium14.copyWith(
                          color: context.themeColors.info,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // ⚠️ CGPA / Credits / Failed مش موجودين في الـ response الحالي
          // بتاع /pending، فمسيباهم مخفيين مؤقتًا لحد ما يتوفر مصدر
          // بيانات ليهم (زي endpoint تفاصيل الطالب الأكاديمية)
        ],
      ),
    );
  }
}
