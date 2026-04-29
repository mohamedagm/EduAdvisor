
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/auth/login/views/choose_user_role.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';

class SecondOnBordaingView extends StatelessWidget {
  const SecondOnBordaingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

body: Column(

  children: [
    SizedBox(height: 150),
   Stack(
  alignment: Alignment.center,
  children: [

    Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient:AppGradients.primary,
      ),
    ),

    /// Gradient Border Circle
    Container(
      width: 240, 
      height: 240,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: SweepGradient(
          colors: [
            AppColors.bluePrimary,
            AppColors.purplePrimary,
          ],
    
        ),

      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), 
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

    
    const SizedBox(height: 30),
    Text(
      'Track Your Progress',
      style: AppTextStyles.heading1_20b.copyWith(color: AppColors.gray800),
    ),
    const SizedBox(height: 24),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Text(
        'Monitor your GPA, simulate grades, and plan your path to academic success',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyInterMedium18.copyWith(color: AppColors.gray600),

      ),
    ),
    const Spacer(),
    GradientElevatedButton(buttonText: 'Get Started', onPressed: () {
      // Handle button press action
      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChooseUserRole(),
                        ),
                      );
    }),
    const SizedBox(height: 70),
  ],
),
    );
  }
}