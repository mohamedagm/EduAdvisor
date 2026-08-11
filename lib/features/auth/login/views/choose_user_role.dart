import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class ChooseUserRole extends StatelessWidget {
  const ChooseUserRole({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return Scaffold(
      backgroundColor: context.themeColors.mutedSurface,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            GradiantContainer(mainText: context.l10n.academicSuccessPartner),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                top: screenHeight * 0.30,
                left: 20.w,
                right: 20.w,
                bottom: 40.w,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.w),
              decoration: BoxDecoration(
                color: context.themeColors.card,
                borderRadius: BorderRadius.circular(28.r),
                boxShadow: [
                  BoxShadow(
                    color: context.themeColors.textPrimary.withValues(
                      alpha: 0.05,
                    ),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.l10n.chooseYourRole,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                      color: context.themeColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8.w),
                  SizedBox(height: 32.w),

                  _buildRoleOption(
                    context: context,
                    icon: Icons.school_rounded,
                    title: context.l10n.student,
                    subtitle: context.l10n.studentRoleDescription,
                    color: context.colorScheme.secondary,
                    onTap: () => context.push(AppRoutes.studentLogin),
                  ),

                  SizedBox(height: 24.w),

                  _buildRoleOption(
                    context: context,
                    icon: Icons.person_3_rounded,
                    title: context.l10n.advisor,
                    subtitle: context.l10n.advisorRoleDescription,
                    color: context.colorScheme.secondary,
                    onTap: () => context.push(AppRoutes.advisorLogin),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5.w),
          borderRadius: BorderRadius.circular(20.r),
          color: context.themeColors.card,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 12.r,
              offset: Offset(0, 4.w),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(icon, size: 36.r, color: color),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: context.themeColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: context.themeColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20.r,
              color: context.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}
