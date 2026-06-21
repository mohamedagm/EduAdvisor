import 'package:edu_advisor/features/services/data/models/registration_request_model.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum RegistrationStatusType { pending, approved, rejected }

class RegistrationStatusCard extends StatelessWidget {
  const RegistrationStatusCard({super.key, required this.request});

  final RegistrationRequestModel request;

  @override
  Widget build(BuildContext context) {
    final status = _statusType(request.status);
    Color borderColor;
    Color color;
    Color badgeBgColor;
    String badgeText;
    IconData icon;

    switch (status) {
      case RegistrationStatusType.approved:
        borderColor = context.themeColors.success.withValues(alpha: 0.3);
        color = context.themeColors.success;
        badgeBgColor = context.themeColors.successContainer;
        badgeText = context.l10n.approved;
        icon = Icons.check_circle_outline;
        break;
      case RegistrationStatusType.pending:
        borderColor = context.themeColors.warning.withValues(alpha: 0.3);
        color = context.themeColors.warning;
        badgeBgColor = context.themeColors.warningContainer;
        badgeText = context.l10n.pending;
        icon = Icons.access_time;
        break;
      case RegistrationStatusType.rejected:
        borderColor = context.colorScheme.error.withValues(alpha: 0.3);
        color = context.colorScheme.error;
        badgeBgColor = context.themeColors.dangerContainer;
        badgeText = context.l10n.rejected;
        icon = Icons.cancel_outlined;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: context.themeColors.card,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20.r),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.w,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: color.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    badgeText,
                    style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoLine(
                  icon: Icons.calendar_month_outlined,
                  title: context.l10n.semester,
                  value: request.semesterName.isNotEmpty
                      ? request.semesterName
                      : context.l10n.semester,
                ),
                SizedBox(height: 10.w),
                _InfoLine(
                  icon: Icons.menu_book_outlined,
                  title: context.l10n.coursesTab,
                  value: context.l10n.coursesCount(request.coursesCount),
                ),
                SizedBox(height: 10.w),
                _InfoLine(
                  icon: Icons.schedule_outlined,
                  title: context.l10n.submitted,
                  value: request.displaySubmittedAt,
                ),
              ],
            ),
          ),

          SizedBox(height: 8.w),
          Divider(height: 1.w, color: context.themeColors.border),

          // Total Courses
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.totalCourses,
                  style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                    color: context.themeColors.textSecondary,
                  ),
                ),
                Text(
                  '${request.coursesCount}',
                  style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1.w, color: context.themeColors.border),

          // Advisor Info & Notes
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor: context.themeColors.border,
                      child: Icon(
                        Icons.person,
                        color: context.themeColors.textMuted,
                        size: 20.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. Hebatulla Nabil',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyInterMedium14.responsive
                                .copyWith(
                                  color: context.themeColors.textPrimary,
                                ),
                          ),
                          Text(
                            context.l10n.academicAdvisor,
                            style: AppTextStyles.bodyInterRegular12.responsive
                                .copyWith(color: context.themeColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (request.notes?.isNotEmpty == true) ...[
                  SizedBox(height: 16.w),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: status == RegistrationStatusType.approved
                          ? context.themeColors.successContainer
                          : context.themeColors.dangerContainer,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status == RegistrationStatusType.rejected
                              ? context.l10n.rejectionReason
                              : context.l10n.advisorNote,
                          style: AppTextStyles.bodyInterRegular12.responsive
                              .copyWith(
                                color: context.themeColors.textSecondary,
                              ),
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          request.notes!,
                          style: AppTextStyles.bodyInterMedium14.responsive
                              .copyWith(
                                color: status == RegistrationStatusType.rejected
                                    ? context.themeColors.onDangerContainer
                                    : context.themeColors.textPrimary,
                                height: 1.4,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  RegistrationStatusType _statusType(String status) {
    switch (status.trim().toLowerCase()) {
      case 'approved':
        return RegistrationStatusType.approved;
      case 'rejected':
        return RegistrationStatusType.rejected;
      default:
        return RegistrationStatusType.pending;
    }
  }
}

class _InfoLine extends StatelessWidget {
  const _InfoLine({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.r, color: context.colorScheme.primary),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
              color: context.themeColors.textMuted,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
