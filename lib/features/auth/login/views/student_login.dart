import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/auth/login/views/forgot_password.dart';
import 'package:edu_advisor/features/auth/login/views/student_profile.dart';
import 'package:edu_advisor/features/auth/signup/views/signup_view.dart';
import 'package:edu_advisor/features/auth/widgets/auth_card.dart';
import 'package:edu_advisor/features/auth/widgets/login_form.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';

import 'package:flutter/material.dart';

class StudentLoginScreen extends StatelessWidget {
  const StudentLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final screenHeight = size.height;

    return Scaffold(
      backgroundColor: AppColors.gray100,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const GradiantContainer(mainText: "Your Academic Success Partner"),

            AuthCard(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Login as Student",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF333333),
                      letterSpacing: -0.5,
                    ),
                  ),

                  const SizedBox(height: 32),

                  const LoginForm(),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.deepPurple.shade400,
                        visualDensity: VisualDensity.compact,
                      ),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: GradientElevatedButton(
                      buttonText: 'Login as student',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentProfile(),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppTextStyles.interRegular16.copyWith(
                          color: AppColors.gray600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(
                              registerRole: RegisterRole.student,
                            ),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: AppTextStyles.bodyInterMedium18.copyWith(
                            color: AppColors.infoBlue,
                          ),
                        ),
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
