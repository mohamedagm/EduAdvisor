import 'package:edu_advisor/features/services/views/widgets/registeration_course_row.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

enum RegistrationStatusType { pending, approved, rejected }

class RegistrationStatusCard extends StatelessWidget {
  final RegistrationStatusType status;
  final List<Map<String, String>> courses;
  final int totalHours;
  final String? advisorNote;
  final String? rejectionReason;

  const RegistrationStatusCard({
    super.key,
    required this.status,
    required this.courses,
    required this.totalHours,
    this.advisorNote,
    this.rejectionReason,
  });

  @override
  Widget build(BuildContext context) {
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

          // Courses
          ...courses.map(
            (c) => RegistrationCourseRow(
              code: c['code']!,
              name: c['name']!,
              credits: c['credits']!,
            ),
          ),

          const SizedBox(height: 8),
          const Divider(height: 1, color: AppColors.gray200),

          // Total Credit Hours
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Credit Hours',
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: AppColors.gray700,
                  ),
                ),
                Text(
                  '$totalHours hours',
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
                if (advisorNote != null) ...[
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
                          'Advisor Note:',
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          advisorNote!,
                          style: AppTextStyles.bodyInterMedium14.copyWith(
                            color: AppColors.gray900,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (rejectionReason != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.redLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Rejection Reason:',
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          rejectionReason!,
                          style: AppTextStyles.bodyInterMedium14.copyWith(
                            color: AppColors
                                .errorRedDark, // Actually a darker shade of red
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
}
