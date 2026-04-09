import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class EmptyCoursesCard extends StatelessWidget {
  const EmptyCoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.gray100,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: AppColors.gray400,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'No courses selected',
            style: AppTextStyles.heading3PoppinsReg16.copyWith(
              color: AppColors.gray700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Click "Add Course" to start',
            style: AppTextStyles.poppinsRegular14.copyWith(
              color: AppColors.gray400,
            ),
          ),
        ],
      ),
    );
  }
}
