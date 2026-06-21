import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

import '../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.servicesTab,
              style: AppTextStyles.heading1_20b.copyWith(
                fontSize: 28.sp,
                color: context.themeColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              context.l10n.servicesDescription,
              style: AppTextStyles.heading3PoppinsReg16.responsive.copyWith(
                color: context.themeColors.textMuted,
              ),
            ),
            SizedBox(height: 32.w),
            Row(
              children: [
                Container(
                  width: 4.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  context.l10n.academicTools,
                  style: AppTextStyles.heading1_20b.copyWith(
                    fontSize: 18.sp,
                    color: context.themeColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),
            _buildServiceCard(
              context: context,
              onTap: () {
                context.push(AppRoutes.courseRecommendations);
              },
              iconBgColor: context.colorScheme.primary,
              iconForegroundColor: context.colorScheme.onPrimary,
              iconData: Icons.lightbulb_outline,
              title: context.l10n.courseRecommendationService,
              subtitle: context.l10n.courseRecommendationServiceDescription,
              badges: [
                _Badge(
                  text: context.l10n.smartRecommendations,
                  textColor: context.colorScheme.primary,
                  bgColor: context.themeColors.infoContainer,
                  borderColor: context.colorScheme.primary.withValues(
                    alpha: 0.2,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),
            _buildServiceCard(
              context: context,
              onTap: () {
                context.push(AppRoutes.courseRegistration);
              },
              iconBgColor: context.themeColors.warning,
              iconForegroundColor: context.themeColors.onWarning,
              iconData: Icons.assignment_outlined,
              title: context.l10n.courseRegistrationTitle,
              subtitle: context.l10n.courseRegistrationServiceDescription,
              badges: [
                _Badge(
                  text: context.l10n.registerNow,
                  textColor: context.themeColors.warning,
                  bgColor: context.themeColors.warningContainer,
                  borderColor: context.themeColors.warning.withValues(
                    alpha: 0.35,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.w),
            _buildServiceCard(
              context: context,
              onTap: () {
                context.push(AppRoutes.registrationStatus);
              },
              iconBgColor: context.themeColors.success,
              iconForegroundColor: context.themeColors.onSuccess,
              iconData: Icons.check_circle_outline,
              title: context.l10n.registrationStatusTitle,
              subtitle: context.l10n.registrationStatusServiceDescription,
              badges: [
                _Badge(
                  text: context.l10n.checkStatus,
                  textColor: context.themeColors.warning,
                  bgColor: context.themeColors.warningContainer,
                  borderColor: context.themeColors.warning.withValues(
                    alpha: 0.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required Color iconBgColor,
    required Color iconForegroundColor,
    required IconData iconData,
    required String title,
    required String subtitle,
    required List<Widget> badges,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.themeColors.card,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.r,
              height: 48.r,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(iconData, color: iconForegroundColor, size: 24.r),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.heading3PoppinsReg16.responsive
                              .copyWith(color: context.themeColors.textPrimary),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: context.themeColors.textMuted,
                        size: 20.r,
                      ),
                    ],
                  ),
                  SizedBox(height: 6.w),
                  Text(
                    subtitle,
                    style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                      color: context.themeColors.textMuted,
                    ),
                  ),
                  SizedBox(height: 12.w),
                  Wrap(spacing: 8.w, runSpacing: 8.w, children: badges),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final Color borderColor;

  const _Badge({
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
