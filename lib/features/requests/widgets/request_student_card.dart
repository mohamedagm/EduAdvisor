import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestStudentCard extends StatelessWidget {
  const RequestStudentCard({super.key, required this.request});

  final StudentRequest request;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.mutedSurface),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: context.themeColors.mutedSurface,
                child: Icon(
                  Icons.person,
                  color: context.themeColors.textMuted,
                  size: 26.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.studentName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.themeColors.textPrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      "${request.studentCode} • ${request.semesterName}",
                      style: TextStyle(
                        color: context.themeColors.textMuted,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              _RequestStatusChip(
                statusName: request.statusName,
                status: request.status,
              ),
            ],
          ),
          SizedBox(height: 16.w),
          Row(
            children: [
              _RequestStatCard(
                icon: Icons.menu_book_rounded,
                value: request.coursesCount.toString(),
                label: context.l10n.coursesLabel,
              ),
              SizedBox(width: 12.w),
              _RequestStatCard(
                icon: Icons.stars_rounded,
                value: request.totalCreditHours.toString(),
                label: context.l10n.creditHoursLabel,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RequestStatusChip extends StatelessWidget {
  const _RequestStatusChip({
    required this.statusName,
    required this.status,
  });

  final String statusName;
  final int status;

  Color _colorFor(BuildContext context) {
    switch (status) {
      case 2:
        return context.themeColors.success;
      case 3:
        return context.colorScheme.error;
      case 1:
      default:
        return context.themeColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorFor(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        statusName,
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _RequestStatCard extends StatelessWidget {
  const _RequestStatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.w),
        decoration: BoxDecoration(
          color: context.themeColors.infoContainer,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: context.colorScheme.primary, size: 20.r),
            SizedBox(height: 6.w),
            Text(
              value,
              style: TextStyle(
                color: context.themeColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: AppTextStyles.bodyInterRegular12.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}