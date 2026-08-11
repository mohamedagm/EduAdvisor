import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

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
        left: 20.w,
        right: 20.w,
        bottom: 40.w,
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: context.themeColors.textPrimary.withValues(
              alpha: 0.05,
            ), //instead of opacity
            blurRadius: 20.r,
            offset: Offset(0, 10.w),
          ),
        ],
      ),
      child: child,
    );
  }
}
