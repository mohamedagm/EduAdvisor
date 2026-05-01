import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

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
    final height = size.height;
    final width = size.width;

    return Container(
      width: double.infinity,
      height: height * 0.39,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.06,
        vertical: height * 0.08,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.bluePrimary, AppColors.purplePrimary],
        ),
      ),
      child: Column(
        children: [
          /// Logo
          Container(
            width: width * 0.25,
            height: width * 0.25,
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

          SizedBox(height: height * 0.02),

          Text(
            mainText,
            style: AppTextStyles.heading1_20b.copyWith(color: AppColors.gray50),
            textAlign: TextAlign.center,
          ),

          if (optionalText != null) ...[
            SizedBox(height: height * 0.01),
            Text(
              optionalText!,
              style: AppTextStyles.heading3PoppinsReg16.copyWith(
                color: AppColors.gray50,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
