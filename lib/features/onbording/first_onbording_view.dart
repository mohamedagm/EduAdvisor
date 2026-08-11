import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:edu_advisor/features/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class FirstOnBordaingView extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const FirstOnBordaingView({
    super.key,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomTextButton(onTap: onSkip, text: context.l10n.skip),
            ],
          ),
        ),
        const Spacer(),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 240.w,
              height: 240.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.primary,
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/Onboardin_one.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 40.w),
        Text(
          context.l10n.aiPoweredRecommendations,
          style: AppTextStyles.heading1_20b.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            context.l10n.personalizedCourseSuggestions,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyInterMedium18.copyWith(
              color: context.themeColors.textSecondary,
            ),
          ),
        ),
        const Spacer(flex: 2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: GradientElevatedButton(
            buttonText: context.l10n.next,
            onPressed: onNext,
          ),
        ),
        SizedBox(height: 20.w),
      ],
    );
  }
}
