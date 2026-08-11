import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class SecondOnBordaingView extends StatelessWidget {
  final VoidCallback onGetStarted;

  const SecondOnBordaingView({super.key, required this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.w),
        const Spacer(),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 220.w,
              height: 220.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.primary,
              ),
            ),
            Container(
              width: 240.w,
              height: 240.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: SweepGradient(
                  colors: [
                    context.colorScheme.primary,
                    context.colorScheme.secondary,
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/Onboardin_two.png',
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
          context.l10n.trackYourProgress,
          style: AppTextStyles.heading1_20b.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Text(
            context.l10n.trackProgressDescription,
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
            buttonText: context.l10n.getStarted,
            onPressed: onGetStarted,
          ),
        ),
        SizedBox(height: 20.w),
      ],
    );
  }
}
