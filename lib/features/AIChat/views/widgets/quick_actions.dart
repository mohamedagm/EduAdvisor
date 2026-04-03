import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key, required this.onActionTap});
  final Function(String) onActionTap;

  @override
  Widget build(BuildContext context) {
    final actions = [
      "Recommend Courses",
      "GPA Simulator",
      "Boost My GPA",
      "Study Plan",
    ];

    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: actions.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 45,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onActionTap(actions[index]),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.purpleLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                actions[index],
                style: AppTextStyles.poppinsRegular14.copyWith(
                  color: AppColors.gray700,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
