import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/AIChat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.w),
        child: Row(
          mainAxisAlignment: isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isUser) ...[
              CircleAvatar(
                radius: 14.r,
                backgroundColor: AppColors.aiPurple,
                child: Icon(
                  Icons.smart_toy,
                  size: 14.r,
                  color: AppColors.white,
                ),
              ),
              SizedBox(width: 6.w),
            ],

            Container(
              constraints: BoxConstraints(maxWidth: 0.7.sw),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w),
              decoration: BoxDecoration(
                color: isUser ? null : context.themeColors.card,
                gradient: isUser ? AppGradients.primary : null,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.r),
                  topRight: Radius.circular(14.r),
                  bottomLeft: isUser ? Radius.circular(14.r) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : Radius.circular(14.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: AppTextStyles.poppinsRegular14.responsive.copyWith(
                      color: isUser
                          ? AppColors.white
                          : context.themeColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 4.w),

                  Text(
                    _formatTime(message.time),
                    style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                      color: isUser
                          ? AppColors.white
                          : context.themeColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            if (isUser) ...[
              SizedBox(width: 6.w),
              CircleAvatar(
                radius: 14.r,
                backgroundColor: context.colorScheme.secondary,
                child: Icon(
                  Icons.person_rounded,
                  size: 14.r,
                  color: context.colorScheme.onSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }
}
