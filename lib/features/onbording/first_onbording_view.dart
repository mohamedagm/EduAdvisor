import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:edu_advisor/features/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
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
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppGradients.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
        const SizedBox(height: 40),
        Text(
          context.l10n.aiPoweredRecommendations,
          style: AppTextStyles.heading1_20b.copyWith(
            color: context.themeColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: GradientElevatedButton(
            buttonText: context.l10n.next,
            onPressed: onNext,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
