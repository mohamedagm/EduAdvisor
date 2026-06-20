import 'package:edu_advisor/features/services/data/models/registration_request_model.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

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
        badgeText = 'Approved';
        icon = Icons.check_circle_outline;
        break;
      case RegistrationStatusType.pending:
        borderColor = context.themeColors.warning.withValues(alpha: 0.3);
        color = context.themeColors.warning;
        badgeBgColor = context.themeColors.warningContainer;
        badgeText = 'Pending';
        icon = Icons.access_time;
        break;
      case RegistrationStatusType.rejected:
        borderColor = context.colorScheme.error.withValues(alpha: 0.3);
        color = context.colorScheme.error;
        badgeBgColor = context.themeColors.dangerContainer;
        badgeText = 'Rejected';
        icon = Icons.cancel_outlined;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: context.themeColors.card,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: color.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    badgeText,
                    style: AppTextStyles.bodyInterRegular12.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoLine(
                  icon: Icons.calendar_month_outlined,
                  title: 'Semester',
                  value: request.displaySemester,
                ),
                const SizedBox(height: 10),
                _InfoLine(
                  icon: Icons.menu_book_outlined,
                  title: 'Courses',
                  value: '${request.coursesCount} courses',
                ),
                const SizedBox(height: 10),
                _InfoLine(
                  icon: Icons.schedule_outlined,
                  title: 'Submitted',
                  value: request.displaySubmittedAt,
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Divider(height: 1, color: context.themeColors.border),

          // Total Courses
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Courses',
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: context.themeColors.textSecondary,
                  ),
                ),
                Text(
                  '${request.coursesCount}',
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: context.themeColors.border),

          // Advisor Info & Notes
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: context.themeColors.border,
                      child: Icon(
                        Icons.person,
                        color: context.themeColors.textMuted,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Dr. Hebatulla Nabil',
                          style: AppTextStyles.bodyInterMedium14.copyWith(
                            color: context.themeColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Academic Advisor',
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: context.themeColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                if (request.notes?.isNotEmpty == true) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: status == RegistrationStatusType.approved
                          ? context.themeColors.successContainer
                          : context.themeColors.dangerContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status == RegistrationStatusType.rejected
                              ? 'Rejection Reason:'
                              : 'Advisor Note:',
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: context.themeColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          request.notes!,
                          style: AppTextStyles.bodyInterMedium14.copyWith(
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
        Icon(icon, size: 18, color: context.colorScheme.primary),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppTextStyles.bodyInterRegular12.copyWith(
            color: context.themeColors.textMuted,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.bodyInterMedium14.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
