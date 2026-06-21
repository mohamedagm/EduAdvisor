import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiInputField extends StatelessWidget {
  const AiInputField({
    super.key,
    required this.controller,
    required this.onSend,
    this.isLoading = false,
  });
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              decoration: BoxDecoration(
                color: context.themeColors.mutedSurface,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TextField(
                controller: controller,
                enabled: !isLoading,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintStyle: AppTextStyles.interRegular16.responsive.copyWith(
                    color: context.themeColors.textMuted,
                  ),
                  hintText: context.l10n.aiChatAskAnythingHint,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: isLoading ? null : onSend,
            child: Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isLoading ? context.colorScheme.outline : null,
                gradient: isLoading ? null : AppGradients.ai,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: isLoading
                  ? SizedBox(
                      width: 24.r,
                      height: 24.r,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.w,
                        color: AppColors.white,
                      ),
                    )
                  : Icon(Icons.send, size: 24.r, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
