import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderAiChat extends StatelessWidget {
  const HeaderAiChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: AppGradients.ai,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.white,
            child: Icon(Icons.smart_toy, size: 24.r, color: AppColors.aiPurple),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.aiChatAssistantTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading3PoppinsReg16.responsive.copyWith(
                    color: AppColors.white,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 4.r,
                      backgroundColor: context.themeColors.success,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      context.l10n.aiChatStatusOnline,
                      style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
