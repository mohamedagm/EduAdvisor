import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/AIChat/message_model.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == MessageSender.user;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isUser) ...[
              const CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.aiPurple,
                child: Icon(Icons.smart_toy, size: 14, color: AppColors.white),
              ),
              const SizedBox(width: 6),
            ],

            Container(
              constraints: const BoxConstraints(maxWidth: 250),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: isUser ? null : AppColors.white,
                gradient: isUser ? AppGradients.primary : null,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(14),
                  topRight: const Radius.circular(14),
                  bottomLeft: isUser ? const Radius.circular(14) : Radius.zero,
                  bottomRight: isUser ? Radius.zero : const Radius.circular(14),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: AppTextStyles.poppinsRegular14.copyWith(
                      color: isUser ? AppColors.white : AppColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    _formatTime(message.time),
                    style: AppTextStyles.bodyInterRegular12.copyWith(
                      color: isUser ? AppColors.white : AppColors.gray600,
                    ),
                  ),
                ],
              ),
            ),

            if (isUser) ...[
              const SizedBox(width: 6),
              const CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.purplePrimary,
                child: Icon(
                  Icons.person_rounded,
                  size: 14,
                  color: AppColors.white,
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
