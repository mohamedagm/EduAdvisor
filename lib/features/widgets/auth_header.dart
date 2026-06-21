import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class GradiantContainer extends StatelessWidget {
  final String mainText;
  final String? optionalText;

  const GradiantContainer({
    super.key,
    required this.mainText,
    this.optionalText,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final logoSize = (width * 0.25).clamp(80.0, 100.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        width * 0.06,
        MediaQuery.paddingOf(context).top + 24,
        width * 0.06,
        64,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colorScheme.primary, context.colorScheme.secondary],
        ),
      ),
      child: Column(
        children: [
          /// Logo
          Container(
            width: logoSize,
            height: logoSize,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(12),
            child: Image.asset(
              'assets/images/EduAdvisor_Logo.png',
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            mainText,
            style: AppTextStyles.heading1_20b.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),

          if (optionalText != null) ...[
            const SizedBox(height: 8),
            Text(
              optionalText!,
              style: AppTextStyles.heading3PoppinsReg16.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
