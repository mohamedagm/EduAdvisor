import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

import '../../../../core/theme/app_text_styles.dart';

class ServicesView extends StatelessWidget {
  const ServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.servicesTab,
              style: AppTextStyles.heading1_20b.copyWith(
                fontSize: 28,
                color: context.themeColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.servicesDescription,
              style: AppTextStyles.heading3PoppinsReg16.copyWith(
                color: context.themeColors.textMuted,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Container(
                  width: 4,
                  height: 20,
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  context.l10n.academicTools,
                  style: AppTextStyles.heading1_20b.copyWith(
                    fontSize: 18,
                    color: context.themeColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
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
            const SizedBox(height: 16),
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.themeColors.card,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(iconData, color: iconForegroundColor, size: 24),
            ),
            const SizedBox(width: 16),
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
                          style: AppTextStyles.heading3PoppinsReg16.copyWith(
                            color: context.themeColors.textPrimary,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: context.themeColors.textMuted,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: AppTextStyles.poppinsRegular14.copyWith(
                      color: context.themeColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(spacing: 8, runSpacing: 8, children: badges),
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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        text,
        style: AppTextStyles.bodyInterRegular12.copyWith(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
