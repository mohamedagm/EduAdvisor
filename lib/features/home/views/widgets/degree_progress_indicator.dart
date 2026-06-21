import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DegreeProgressIndicator extends StatelessWidget {
  const DegreeProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.themeColors.border.withValues(alpha: 0.5),
            blurRadius: 10.r,
            offset: Offset(0, 4.w),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.degreeProgress,
                      style: AppTextStyles.heading3PoppinsReg16.copyWith(
                        fontSize: 16.sp,
                        color: context.themeColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      context.l10n.degreeProgramName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.poppinsRegular14.copyWith(
                        fontSize: 14.sp,
                        color: context.themeColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    context.l10n.creditsRatio('65', '140'),
                    style: AppTextStyles.interRegular16.copyWith(
                      fontSize: 16.sp,
                      color: context.themeColors.info,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    context.l10n.creditsLabel,
                    textAlign: TextAlign.end,
                    style: AppTextStyles.interRegular16.copyWith(
                      fontSize: 16.sp,
                      color: context.themeColors.info,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 16.w),

          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(16.r),
            value: 65 / 140,
            minHeight: 10.w,
            backgroundColor: context.themeColors.border,
            valueColor: AlwaysStoppedAnimation<Color>(
              context.themeColors.textPrimary,
            ),
          ),

          SizedBox(height: 16.w),

          Text(
            context.l10n.onTrackToGraduate(context.l10n.spring2026),
            style: AppTextStyles.poppinsRegular14.copyWith(
              fontSize: 14.sp,
              color: context.themeColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
