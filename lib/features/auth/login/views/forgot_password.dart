import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/custom_text_button.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            GradiantContainer(
              mainText: "Forgot Password?",
              optionalText: "Don't worry! we'll help you reset it.",
            ),

            ///  Card Section
            Container(
              margin: EdgeInsets.only(
                top: height * 0.41,
                right: width * 0.03,
                left: width * 0.03,
              ),
              constraints: BoxConstraints(
                minHeight: height * 0.35, //
              ),
              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Email field
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "your.email@university.edu.eg",
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: AppColors.gray400.withValues(alpha: 0.1),

                      ///
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "We'll send a 6-digit verification code to this email",
                    style: AppTextStyles.bodyInterMedium14.copyWith(
                      color: AppColors.gray400,
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Button
                  GradientElevatedButton(
                    buttonText: 'Send Verfication code ',
                    onPressed: () {
                      context.push(AppRoutes.verifyCode);
                    },
                  ),

                  const SizedBox(height: 24),

                  /// Back to login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember your password? ",
                        style: AppTextStyles.bodyInterMedium14.copyWith(
                          color: AppColors.gray600,
                        ),
                      ),
                      CustomTextButton(
                        onTap: () {
                          context.pop();
                        },
                        text: 'Back to Login',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
