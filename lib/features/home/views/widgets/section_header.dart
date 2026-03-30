import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recommended Courses',
          style: AppTextStyles.poppinsRegular14.copyWith(
            color: AppColors.gray800,
          ),
        ),
        Text(
          'View All',
          style: AppTextStyles.poppinsRegular14.copyWith(
            color: AppColors.infoBlue,
          ),
        ),
      ],
    );
  }
}
