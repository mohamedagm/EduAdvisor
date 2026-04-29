import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class RegistrationCourseRow extends StatelessWidget {
  final String code;
  final String name;
  final String credits;

  const RegistrationCourseRow({
    super.key,
    required this.code,
    required this.name,
    required this.credits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.menu_book_outlined,
            color: AppColors.bluePrimary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  code,
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: AppColors.gray900,
                  ),
                ),
                if (name.isNotEmpty)
                  Text(
                    name,
                    style: AppTextStyles.bodyInterRegular12.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.gray200),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              credits,
              style: AppTextStyles.bodyInterRegular12.copyWith(
                color: AppColors.gray900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
