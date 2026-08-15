import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onTap;
  const SkipButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.secondary.withValues(alpha: 0.3),
            blurRadius: 12.r,
            offset: Offset(0, 6.w),
          ),
        ],
      ),
      width: double.infinity,
      height: 48.w,
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.skip_next, size: 20.r),
          SizedBox(width: 16.w),
          TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              foregroundColor: context.themeColors.textSecondary,
              padding: EdgeInsets.symmetric(vertical: 12.w),
            ),
            child: Text(
              context.l10n.skipForNow,
              style: TextStyle(fontSize: 16.sp),
            ),
          ),
        ],
      ),
    );
  }
}
