import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key, required this.onActionTap});
  final Function(String) onActionTap;

  @override
  Widget build(BuildContext context) {
    final actions = [
      context.l10n.aiChatQuickActionRecommendCourses,
      context.l10n.aiChatQuickActionGpaSimulator,
      context.l10n.aiChatQuickActionBoostMyGpa,
      context.l10n.aiChatQuickActionStudyPlan,
    ];

    return Container(
      margin: EdgeInsets.all(12.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: actions.length,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 45.w,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onActionTap(actions[index]),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.themeColors.purpleContainer,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                actions[index],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                  color: context.themeColors.textSecondary,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
