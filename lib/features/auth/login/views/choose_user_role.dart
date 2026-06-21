import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/login/views/student_login.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:flutter/material.dart';
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
                top: screenHeight * 0.30, // يبدأ من مسافة متناسبة مع طول الشاشة
                left: 20,
                right: 20,
                bottom: 40, // مسافة تحت عشان الـ Scroll
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: context.themeColors.card,
                borderRadius: BorderRadius.circular(28),
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
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: context.themeColors.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    context.l10n.continueToApp,
                    style: TextStyle(
                      fontSize: 15,
                      color: context.themeColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 32),

                  _buildRoleOption(
                    context: context,
                    icon: Icons.school_rounded,
                    title: context.l10n.student,
                    subtitle: context.l10n.studentRoleDescription,
                    color: context.colorScheme.secondary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentLoginScreen(
                            registerRole: RegisterRole.student,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  _buildRoleOption(
                    context: context,
                    icon: Icons.person_3_rounded,
                    title: context.l10n.advisor,
                    subtitle: context.l10n.advisorRoleDescription,
                    color: context.colorScheme.secondary,
                    onTap: () {
                      context.push(AppRoutes.advisorLogin);
                    },
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
          borderRadius: BorderRadius.circular(20),
          color: context.themeColors.card,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, size: 36, color: color),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: context.themeColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.themeColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: context.colorScheme.outline,
            ),
          ],
        ),
      ),
    );
  }
}
