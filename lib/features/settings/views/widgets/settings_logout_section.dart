import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsLogoutSection extends StatelessWidget {
  const SettingsLogoutSection({super.key, required this.isLoggingOut});

  final bool isLoggingOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: context.colorScheme.error.withValues(alpha: 0.2),
        ),
      ),
      child: IgnorePointer(
        ignoring: isLoggingOut,
        child: GestureDetector(
          onTap: () => context.read<AuthCubit>().logout(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 14.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: context.colorScheme.error.withValues(alpha: 0.4),
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoggingOut) ...[
                  SizedBox(
                    width: 18.r,
                    height: 18.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.w,
                      color: context.colorScheme.error,
                    ),
                  ),
                ] else ...[
                  Icon(
                    Icons.logout,
                    size: 24.r,
                    color: context.colorScheme.error,
                  ),
                ],
                SizedBox(width: 8.w),
                Text(
                  isLoggingOut ? context.l10n.loggingOut : context.l10n.logOut,
                  style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                    color: context.colorScheme.error,
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
