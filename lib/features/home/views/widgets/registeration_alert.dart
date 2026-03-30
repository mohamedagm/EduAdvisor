import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class RegisterationAlert extends StatelessWidget {
  const RegisterationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: AppColors.gray200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Container(
            height: 48,
            width: 48,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.bluePrimary.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.calendar_month, color: AppColors.infoBlue),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Registration Alert',
                  style: AppTextStyles.heading3PoppinsReg16.copyWith(
                    color: AppColors.gray800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Spring 2025 course registration opens in 3 days. Check your saved schedule.',
                  style: AppTextStyles.poppinsRegular14.copyWith(
                    color: AppColors.gray600,
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
