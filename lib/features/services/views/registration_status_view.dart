import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'widgets/registration_summary_box.dart';
import 'widgets/registration_status_card.dart';
import 'widgets/service_app_bar.dart';

class RegistrationStatusView extends StatelessWidget {
  const RegistrationStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray50,
      appBar: const ServiceAppBar(
        title: 'Registration Status',
        subtitle: 'Track your course requests',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RegistrationSummaryBox(
                  icon: Icons.access_time,
                  color: AppColors.warningAmberDark,
                  bgColor: AppColors.yellowLight,
                  count: '2',
                  label: 'Pending',
                ),
                const SizedBox(width: 12),
                RegistrationSummaryBox(
                  icon: Icons.check_circle_outline,
                  color: AppColors.successGreenDark,
                  bgColor: AppColors.greenLight,
                  count: '3',
                  label: 'Approved',
                ),
                const SizedBox(width: 12),
                RegistrationSummaryBox(
                  icon: Icons.cancel_outlined,
                  color: AppColors.errorRed,
                  bgColor: AppColors.redLight,
                  count: '1',
                  label: 'Rejected',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'All Registrations',
              style: AppTextStyles.heading1_20b.copyWith(
                fontSize: 16,
                color: AppColors.gray900,
              ),
            ),
            const SizedBox(height: 16),
            RegistrationStatusCard(
              status: RegistrationStatusType.approved,
              courses: [
                {
                  'code': 'IS 312',
                  'name': 'Data base Management System',
                  'credits': '3 cr',
                },
                {
                  'code': 'CS 201',
                  'name': 'Data structures & Algorithms',
                  'credits': '3 cr',
                },
                {'code': 'MATH 301', 'name': 'Math 3', 'credits': '3 cr'},
              ],
              totalHours: 9,
            ),
            const SizedBox(height: 16),
            RegistrationStatusCard(
              status: RegistrationStatusType.pending,
              courses: [
                {
                  'code': 'CS 391',
                  'name': 'Software Engineering',
                  'credits': '3 cr',
                },
                {
                  'code': 'CS 340',
                  'name': 'Computer Networks',
                  'credits': '3 cr',
                },
              ],
              totalHours: 6,
            ),
            const SizedBox(height: 16),
            RegistrationStatusCard(
              status: RegistrationStatusType.rejected,
              courses: [
                {'code': 'CS 450', 'name': '', 'credits': '3 cr'},
              ],
              totalHours: 3,
              advisorNote:
                  'Prerequisites not met for CS 450. Please complete CS 301 first.',
              rejectionReason: 'Missing prerequisites for AI course.',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
