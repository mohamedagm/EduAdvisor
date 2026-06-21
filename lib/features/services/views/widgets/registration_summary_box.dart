import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationSummaryBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  final String count;
  final String label;

  const RegistrationSummaryBox({
    super.key,
    required this.icon,
    required this.color,
    required this.bgColor,
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: color.withValues(alpha: 0.2)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24.r),
            SizedBox(height: 8.w),
            Text(
              count,
              style: AppTextStyles.heading1_20b.copyWith(
                fontSize: 24.sp,
                color: color,
              ),
            ),
            SizedBox(height: 4.w),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
