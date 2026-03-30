import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class DegreeProgressIndicator extends StatelessWidget {
  const DegreeProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Degree Progress',
                    style: AppTextStyles.heading3PoppinsReg16.copyWith(
                      color: AppColors.gray800,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Bachelor of Computer Science',
                    style: AppTextStyles.poppinsRegular14.copyWith(
                      color: AppColors.gray600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '65 / 140',
                    style: AppTextStyles.interRegular16.copyWith(
                      color: AppColors.infoBlue,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Credits',
                    style: AppTextStyles.interRegular16.copyWith(
                      color: AppColors.infoBlue,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 16),

          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(16),
            value: 65 / 140,
            minHeight: 10,
            backgroundColor: AppColors.gray200,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.gray900),
          ),

          const SizedBox(height: 16),

          Text(
            'You are on track to graduate in Spring 2026.',
            style: AppTextStyles.poppinsRegular14.copyWith(
              color: AppColors.gray600,
            ),
          ),
        ],
      ),
    );
  }
}
