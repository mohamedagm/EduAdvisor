import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class GradientElevatedButton extends StatelessWidget {
  const GradientElevatedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });

  final String? buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height; // ✅

    return Container(
      width: double.infinity,
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppColors.bluePrimary, AppColors.purplePrimary],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 169, 153, 196),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // ✅ نفس رقم الـ Container
          ),
        ),
        child: Text(
          buttonText ?? '',
          style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.022, // ✅ بدل 18 ثابتة
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
