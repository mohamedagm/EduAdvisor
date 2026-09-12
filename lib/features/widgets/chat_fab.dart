import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatFab extends StatelessWidget {
  const ChatFab({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      elevation: 8,
      backgroundColor: Colors.transparent,
      shape: const CircleBorder(),
      child: Container(
        width: 60.r,
        height: 60.r,
        decoration: BoxDecoration(
          gradient: AppGradients.ai,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.aiPurple.withValues(alpha: 0.4),
              blurRadius: 16.r,
              offset: Offset(0, 6.w),
            ),
          ],
        ),
        child: const Icon(
          Icons.smart_toy_outlined,
          color: AppColors.white,
        ),
      ),
    );
  }
}