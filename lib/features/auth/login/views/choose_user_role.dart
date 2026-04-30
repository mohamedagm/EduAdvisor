
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/features/auth/login/views/advisor_login.dart';
import 'package:edu_advisor/features/auth/login/views/student_login.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:flutter/material.dart';

class ChooseUserRole extends StatelessWidget {
  const ChooseUserRole({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return Scaffold(
      backgroundColor: AppColors.gray100,
      body: SingleChildScrollView(
        child: Stack(
          children: [
          GradiantContainer(
  mainText: "Your Academic Success Partner",
 
),
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
                color: AppColors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Choose Your Role",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "to continue to EduAdvisor",
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
                  ),

                  const SizedBox(height: 48),

                  _buildRoleOption(
                    context: context,
                    icon: Icons.school_rounded,
                    title: "Student",
                    subtitle: "Access courses, grades & schedule",
                    color: AppColors.purplePrimary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StudentLoginScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  _buildRoleOption(
                    context: context,
                    icon: Icons.person_3_rounded,
                    title: "Advisor",
                    subtitle: "Manage students & academic advising",
                    color: AppColors.purplePrimary,
                    onTap: () {
                       Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AdvisorLoginScreen(),
  ),
);
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
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
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
