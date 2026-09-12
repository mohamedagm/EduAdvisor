import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/services/views/widgets/course_registration_tool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.courseRegistrationTitle,
              style: AppTextStyles.heading1_20b.copyWith(
                fontSize: 28.sp,
                color: context.themeColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              context.l10n.courseRegistrationServiceDescription,
              style: AppTextStyles.heading3PoppinsReg16.responsive.copyWith(
                color: context.themeColors.textMuted,
              ),
            ),
            SizedBox(height: 20.w),
            _AiRecommendationsBanner(
              onTap: () => context.push(AppRoutes.courseRecommendations),
            ),
            SizedBox(height: 24.w),
            const CourseRegistrationTool(),
          ],
        ),
      ),
    );
  }
}

class _AiRecommendationsBanner extends StatelessWidget {
  const _AiRecommendationsBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: AppGradients.ai,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.aiPurple.withValues(alpha: 0.25),
                blurRadius: 14.r,
                offset: Offset(0, 5.w),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: AppColors.white,
                  size: 22.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.courseRecommendationsTitle,
                      style: AppTextStyles.heading3PoppinsReg16.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      context.l10n.aiPoweredSuggestionsForYou,
                      style: AppTextStyles.bodyInterRegular12.copyWith(
                        color: AppColors.white.withValues(alpha: 0.92),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.r,
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}