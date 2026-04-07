import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class HeaderAiChat extends StatelessWidget {
  const HeaderAiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: AppGradients.ai,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: AppColors.white,
            child: Icon(Icons.smart_toy, color: AppColors.aiPurple),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "AI Assistant",
                style: AppTextStyles.heading3PoppinsReg16.copyWith(
                  color: AppColors.white,
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: AppColors.successGreen,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Online",
                    style: AppTextStyles.poppinsRegular14.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
