import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          style: AppTextStyles.heading1_20b.responsive.copyWith(
            color: AppColors.white,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.w),
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    context.l10n.unreadNotifications(2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                      color: AppColors.white.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.done_all,
                        color: AppColors.white.withValues(alpha: 0.9),
                        size: 18.r,
                      ),
                      SizedBox(width: 4.w),
                      Flexible(
                        child: Text(
                          context.l10n.markAllAsRead,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyInterMedium14.responsive
                              .copyWith(
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
        padding: EdgeInsets.all(16.w),
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
            SizedBox(height: 12.w),
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
            SizedBox(height: 12.w),
            _buildInfoNotificationCard(
              context: context,
              isAlert: false,
              title: context.l10n.newCourseAvailable,
              subtitle: context.l10n.courseAvailableForEnrollment(
                'CS401 - ${context.l10n.advancedAlgorithms}',
              ),
              time: context.l10n.hoursAgo(5),
            ),
            SizedBox(height: 12.w),
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: context.themeColors.card,
              shape: BoxShape.circle,
              border: Border.all(color: context.themeColors.border),
            ),
            child: Icon(iconData, color: iconColor, size: 20.r),
          ),
          SizedBox(width: 12.w),
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
                        style: AppTextStyles.interRegular16.responsive.copyWith(
                          fontWeight: FontWeight.w500,
                          color: context.themeColors.textPrimary,
                        ),
                      ),
                    ),
                    if (isNew) ...[
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.w,
                        ),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          context.l10n.newNotification,
                          style: AppTextStyles.bodyInterRegular12.copyWith(
                            color: context.colorScheme.onPrimary,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 6.w),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                    color: context.themeColors.textMuted,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12.w),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: context.themeColors.card,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: context.themeColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        innerCardCode,
                        style: AppTextStyles.bodyInterMedium14.responsive
                            .copyWith(color: context.themeColors.textPrimary),
                      ),
                      SizedBox(height: 2.w),
                      Text(
                        innerCardName,
                        style: AppTextStyles.bodyInterRegular12.responsive
                            .copyWith(color: context.themeColors.textMuted),
                      ),
                    ],
                  ),
                ),
                if (hasRejectionReason) ...[
                  SizedBox(height: 12.w),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          context.l10n.viewRejectionReason,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyInterMedium14.responsive
                              .copyWith(color: context.colorScheme.error),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: context.colorScheme.error,
                        size: 20.r,
                      ),
                    ],
                  ),
                ],
                SizedBox(height: 12.w),
                Text(
                  time,
                  style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
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
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: context.themeColors.card,
              shape: BoxShape.circle,
              border: Border.all(color: context.themeColors.border),
            ),
            child: Icon(iconData, color: iconColor, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.interRegular16.responsive.copyWith(
                    fontWeight: FontWeight.w700,
                    color: context.themeColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6.w),
                Text(
                  subtitle,
                  style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                    color: context.themeColors.textMuted,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12.w),
                Text(
                  time,
                  style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
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
