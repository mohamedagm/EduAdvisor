import 'package:edu_advisor/features/services/data/models/registration_request_model.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

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
        borderColor = AppColors.successGreen.withValues(alpha: 0.3);
        color = AppColors.successGreenDark;
        badgeBgColor = AppColors.greenLight;
        badgeText = 'Approved';
        icon = Icons.check_circle_outline;
        break;
      case RegistrationStatusType.pending:
        borderColor = AppColors.warningAmber.withValues(alpha: 0.3);
        color = AppColors.warningAmberDark;
        badgeBgColor = AppColors.yellowLight;
        badgeText = 'Pending';
        icon = Icons.access_time;
        break;
      case RegistrationStatusType.rejected:
        borderColor = AppColors.errorRed.withValues(alpha: 0.3);
        color = AppColors.errorRed;
        badgeBgColor = AppColors.redLight;
        badgeText = 'Rejected';
        icon = Icons.cancel_outlined;
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
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
          const Divider(height: 1, color: AppColors.gray200),

          // Total Courses
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Courses',
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: AppColors.gray700,
                  ),
                ),
                Text(
                  '${request.coursesCount}',
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: AppColors.bluePrimary,
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.gray200),

          // Advisor Info & Notes
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.gray200,
                      child: Icon(
                        Icons.person,
                        color: AppColors.gray500,
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
                            color: AppColors.gray900,
                          ),
                        ),
                        Text(
                          'Academic Advisor',
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: AppColors.gray500,
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
                          ? AppColors.greenLight
                          : AppColors.redLight,
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
                            color: AppColors.gray600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          request.notes!,
                          style: AppTextStyles.bodyInterMedium14.copyWith(
                            color: status == RegistrationStatusType.rejected
                                ? AppColors.errorRedDark
                                : AppColors.gray900,
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
        Icon(icon, size: 18, color: AppColors.bluePrimary),
        const SizedBox(width: 10),
        Text(
          title,
          style: AppTextStyles.bodyInterRegular12.copyWith(
            color: AppColors.gray500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: AppTextStyles.bodyInterMedium14.copyWith(
            color: AppColors.gray900,
          ),
        ),
      ],
    );
  }
}
