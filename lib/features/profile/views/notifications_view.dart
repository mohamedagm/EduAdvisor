import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_gradiants.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppGradients.primary),
        ),
        leading: BackButton(
          color: AppColors.white,
          onPressed: () => context.pop(),
        ),
        title: Text(
          context.l10n.notifications,
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
                Expanded(
                  child: Text(
                    context.l10n.unreadNotifications(2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyInterMedium14.copyWith(
                      color: AppColors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.done_all,
                        color: AppColors.white.withValues(alpha: 0.9),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          context.l10n.markAllAsRead,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyInterMedium14.copyWith(
                            color: AppColors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ),
                    ],
                  ),
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
              context: context,
              isSuccess: true,
              title: context.l10n.courseRegistrationApproved,
              subtitle: context.l10n.courseRegistrationApprovedMessage,
              time: context.l10n.hoursAgo(1),
              isNew: true,
              innerCardCode: 'IS 312',
              innerCardName: context.l10n.databaseSystems,
            ),
            const SizedBox(height: 12),
            _buildStatusNotificationCard(
              context: context,
              isSuccess: false,
              title: context.l10n.courseRegistrationRejected,
              subtitle: context.l10n.courseRegistrationRejectedMessage,
              time: context.l10n.hoursAgo(2),
              isNew: true,
              innerCardCode: 'CS450',
              innerCardName: context.l10n.artificialIntelligence,
              hasRejectionReason: true,
            ),
            const SizedBox(height: 12),
            _buildInfoNotificationCard(
              context: context,
              isAlert: false,
              title: context.l10n.newCourseAvailable,
              subtitle: context.l10n.courseAvailableForEnrollment(
                'CS401 - ${context.l10n.advancedAlgorithms}',
              ),
              time: context.l10n.hoursAgo(5),
            ),
            const SizedBox(height: 12),
            _buildInfoNotificationCard(
              context: context,
              isAlert: true,
              title: context.l10n.registrationDeadline,
              subtitle: context.l10n.registrationDeadlineMessage(
                context.l10n.spring2024,
                3,
              ),
              time: context.l10n.daysAgo(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusNotificationCard({
    required BuildContext context,
    required bool isSuccess,
    required String title,
    required String subtitle,
    required String time,
    required bool isNew,
    required String innerCardCode,
    required String innerCardName,
    bool hasRejectionReason = false,
  }) {
    final bgColor = isSuccess
        ? context.themeColors.successContainer
        : context.themeColors.dangerContainer;
    final borderColor = isSuccess
        ? context.themeColors.success.withValues(alpha: 0.3)
        : context.colorScheme.error.withValues(alpha: 0.3);
    final iconData = isSuccess
        ? Icons.check_circle_outline
        : Icons.cancel_outlined;
    final iconColor = isSuccess
        ? context.themeColors.success
        : context.colorScheme.error;

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
              color: context.themeColors.card,
              shape: BoxShape.circle,
              border: Border.all(color: context.themeColors.border),
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
                          color: context.themeColors.textPrimary,
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
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          context.l10n.newNotification,
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: context.colorScheme.onPrimary,
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
                    color: context.themeColors.textMuted,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.themeColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: context.themeColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        innerCardCode,
                        style: AppTextStyles.bodyInterMedium14.copyWith(
                          color: context.themeColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        innerCardName,
                        style: AppTextStyles.bodyInterRegular12.copyWith(
                          color: context.themeColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                if (hasRejectionReason) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          context.l10n.viewRejectionReason,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyInterMedium14.copyWith(
                            color: context.colorScheme.error,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: context.colorScheme.error,
                        size: 20,
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  time,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: context.themeColors.textMuted,
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
    required BuildContext context,
    required bool isAlert,
    required String title,
    required String subtitle,
    required String time,
  }) {
    final iconData = isAlert
        ? Icons.calendar_today_outlined
        : Icons.menu_book_outlined;
    final iconColor = isAlert
        ? context.themeColors.warning
        : context.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.themeColors.card,
              shape: BoxShape.circle,
              border: Border.all(color: context.themeColors.border),
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
                    color: context.themeColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: context.themeColors.textMuted,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  time,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: context.themeColors.textMuted,
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
