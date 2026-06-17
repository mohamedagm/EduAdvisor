import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller,
                enabled: !isLoading,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintStyle: AppTextStyles.interRegular16.copyWith(
                    color: AppColors.gray400,
                  ),
                  hintText: "Ask me anything...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: isLoading ? null : onSend,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isLoading ? AppColors.gray300 : null,
                gradient: isLoading ? null : AppGradients.ai,
                borderRadius: BorderRadius.circular(10),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.white,
                      ),
                    )
                  : const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
