import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';

class RequestActionButtons extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RequestActionButtons({
    super.key,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onAccept,
              icon: const Icon(Icons.check_circle_outline),
              label: const Text("Accept"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.successGreenDark,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: onReject,
              icon: const Icon(Icons.cancel_outlined),
              label: const Text("Reject"),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.errorRed,
                side: const BorderSide(color: AppColors.errorRed),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}