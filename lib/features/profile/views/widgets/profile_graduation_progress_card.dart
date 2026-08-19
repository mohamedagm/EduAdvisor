import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileGraduationProgressCard extends StatelessWidget {
  const ProfileGraduationProgressCard({super.key});

  static const int totalRequiredCredits = 144;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        final user = state is CurrentUserLoaded ? state.user : null;

        return _GraduationProgressContent(user: user);
      },
    );
  }
}

class _GraduationProgressContent extends StatelessWidget {
  const _GraduationProgressContent({required this.user});

  final CurrentUserModel? user;

  @override
  Widget build(BuildContext context) {
    final completed = user?.completedCreditHours?.toInt() ?? 0;
    final total = ProfileGraduationProgressCard.totalRequiredCredits;
    final ratio = total > 0 ? (completed / total).clamp(0.0, 1.0) : 0.0;
    final remaining = (total - completed).clamp(0, total);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: context.themeColors.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: context.themeColors.border, width: 2.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.progressToGraduation,
              style: AppTextStyles.heading2PoppinsSb18.responsive,
            ),
            SizedBox(height: 12.w),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    context.l10n.creditsCompleted,
                    style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                      color: context.themeColors.textSecondary,
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  context.l10n.creditsRatio(
                    completed.toString(),
                    total.toString(),
                  ),
                  style: AppTextStyles.bodyInterMedium14.responsive,
                ),
              ],
            ),

            SizedBox(height: 8.w),

            LinearProgressIndicator(
              color: context.themeColors.textPrimary,
              backgroundColor: context.colorScheme.outline,
              minHeight: 12.w,
              value: ratio,
              borderRadius: BorderRadius.circular(10.r),
            ),

            SizedBox(height: 8.w),

            Text(
              context.l10n.creditsRemaining(remaining),
              style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
