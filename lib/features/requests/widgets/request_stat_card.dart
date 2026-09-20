import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequestStatCard extends StatelessWidget {
  const RequestStatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.w),
        decoration: BoxDecoration(
          color: context.themeColors.infoContainer,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: context.colorScheme.primary,
              size: 20.r,
            ),
            SizedBox(height: 6.w),
            Text(
              value,
              style: TextStyle(
                color: context.themeColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: AppTextStyles.bodyInterRegular12.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}