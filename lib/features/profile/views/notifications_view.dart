import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradiants.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppGradients.primary),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Notifications',
          style: AppTextStyles.heading1_20b.copyWith(color: AppColors.white),
        ),
        centerTitle: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '2 unread notifications',
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: AppColors.white.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.done_all,
                      color: AppColors.white.withValues(alpha: 0.9),
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Mark all as read',
                      style: AppTextStyles.bodyInterMedium14.copyWith(
                        color: AppColors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildStatusNotificationCard(
              isSuccess: true,
              title: 'Course Registration Approved',
              subtitle: 'Your course registration request has been approved',
              time: '1 hour ago',
              isNew: true,
              innerCardCode: 'IS 312',
              innerCardName: 'Database systems',
            ),
            const SizedBox(height: 12),
            _buildStatusNotificationCard(
              isSuccess: false,
              title: 'Course Registration Rejected',
              subtitle: 'Your course registration request was rejected',
              time: '2 hours ago',
              isNew: true,
              innerCardCode: 'CS450',
              innerCardName: 'Artificial Intelligence',
              hasRejectionReason: true,
            ),
            const SizedBox(height: 12),
            _buildInfoNotificationCard(
              isAlert: false,
              title: 'New Course Available',
              subtitle:
                  'CS401 - Advanced Algorithms is now available for enrollment',
              time: '5 hours ago',
            ),
            const SizedBox(height: 12),
            _buildInfoNotificationCard(
              isAlert: true,
              title: 'Registration Deadline',
              subtitle: 'Course registration for Spring 2024 ends in 3 days',
              time: '2 days ago',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusNotificationCard({
    required bool isSuccess,
    required String title,
    required String subtitle,
    required String time,
    required bool isNew,
    required String innerCardCode,
    required String innerCardName,
    bool hasRejectionReason = false,
  }) {
    final bgColor = isSuccess ? AppColors.greenLight : AppColors.redLight;
    final borderColor = isSuccess
        ? AppColors.successGreen.withValues(alpha: 0.3)
        : AppColors.errorRed.withValues(alpha: 0.3);
    final iconData = isSuccess
        ? Icons.check_circle_outline
        : Icons.cancel_outlined;
    final iconColor = isSuccess
        ? AppColors.successGreenDark
        : AppColors.errorRed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gray200),
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppTextStyles.interRegular16.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.gray900,
                        ),
                      ),
                    ),
                    if (isNew) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.bluePrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'New',
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: AppColors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: AppColors.gray500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.gray200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        innerCardCode,
                        style: AppTextStyles.bodyInterMedium14.copyWith(
                          color: AppColors.gray900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        innerCardName,
                        style: AppTextStyles.bodyInterRegular12.copyWith(
                          color: AppColors.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasRejectionReason) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'View rejection reason',
                        style: AppTextStyles.bodyInterMedium14.copyWith(
                          color: AppColors.errorRed,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.errorRed,
                        size: 20,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  time,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: AppColors.gray400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoNotificationCard({
    required bool isAlert,
    required String title,
    required String subtitle,
    required String time,
  }) {
    final iconData = isAlert
        ? Icons.calendar_today_outlined
        : Icons.menu_book_outlined;
    final iconColor = isAlert
        ? AppColors.warningAmberDark
        : AppColors.bluePrimary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gray200),
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.interRegular16.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.gray900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: AppColors.gray500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  time,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: AppColors.gray400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
