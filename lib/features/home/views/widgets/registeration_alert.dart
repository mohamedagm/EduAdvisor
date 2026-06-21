import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterationAlert extends StatelessWidget {
  const RegisterationAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.infoContainer,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.themeColors.info.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: context.themeColors.info.withValues(alpha: 0.1),
            blurRadius: 10.r,
            offset: Offset(0, 4.w),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.w,
        children: [
          Container(
            height: 48.r,
            width: 48.r,
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: context.themeColors.infoContainer,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.calendar_month,
              size: 24.r,
              color: context.themeColors.info,
            ),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.registrationAlert,
                  style: AppTextStyles.heading3PoppinsReg16.copyWith(
                    fontSize: 16.sp,
                    color: context.themeColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.w),
                Text(
                  context.l10n.registrationAlertMessage,
                  style: AppTextStyles.poppinsRegular14.copyWith(
                    fontSize: 14.sp,
                    color: context.themeColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
