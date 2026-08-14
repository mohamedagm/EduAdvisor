import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class CoursesCard extends StatelessWidget {
  const CoursesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _cardWrapper(
      context: context,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Popular Courses',
            style: AppTextStyles.heading3PoppinsReg16.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          const _CourseRow(code: 'CS201', name: 'Data Structures', enrolled: 32),
        ],
      ),
    );
  }

  Widget _cardWrapper({required BuildContext context, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

class _CourseRow extends StatelessWidget {
  final String code;
  final String name;
  final int enrolled;

  const _CourseRow({
    required this.code,
    required this.name,
    required this.enrolled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$code - $name',
          style: AppTextStyles.bodyInterMedium14.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
        Text(
          '$enrolled',
          style: AppTextStyles.bodyInterRegular12.copyWith(
            color: context.themeColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
