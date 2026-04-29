import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        top: screenHeight * 0.30,
        left: 20,
        right: 20,
        bottom: 40,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
           color: Colors.black.withValues(alpha: 0.05),//instead of opacity
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child, 
    );
  }
}