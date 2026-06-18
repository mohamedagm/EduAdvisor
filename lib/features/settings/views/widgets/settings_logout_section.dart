import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsLogoutSection extends StatelessWidget {
  const SettingsLogoutSection({super.key, required this.isLoggingOut});

  final bool isLoggingOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.errorRed.withValues(alpha: 0.2)),
      ),
      child: IgnorePointer(
        ignoring: isLoggingOut,
        child: GestureDetector(
          onTap: () => context.read<AuthCubit>().logout(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.errorRed.withValues(alpha: 0.4),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoggingOut) ...[
                  const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.errorRed,
                    ),
                  ),
                ] else ...[
                  const Icon(Icons.logout, color: AppColors.errorRed),
                ],
                const SizedBox(width: 8),
                Text(
                  isLoggingOut ? 'Logging out...' : 'Log Out',
                  style: AppTextStyles.bodyInterMedium14.copyWith(
                    color: AppColors.errorRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
