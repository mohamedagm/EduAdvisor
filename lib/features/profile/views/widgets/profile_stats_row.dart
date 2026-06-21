import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_Stat_card.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        if (state is CurrentUserInitial || state is CurrentUserLoading) {
          return AppShimmer(
            child: Row(
              children: [
                Expanded(
                  child: AppShimmerBox(height: 120.w, borderRadius: 16.r),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: AppShimmerBox(height: 120.w, borderRadius: 16.r),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: AppShimmerBox(height: 120.w, borderRadius: 16.r),
                ),
              ],
            ),
          );
        }

        final user = state is CurrentUserLoaded ? state.user : null;

        return Row(
          children: [
            Expanded(
              child: ProfileStatCard(
                title: context.l10n.gpa,
                value: user?.displayGpa ?? "--",
                icon: Icons.emoji_events,
                iconColor: context.colorScheme.primary,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: ProfileStatCard(
                title: context.l10n.creditsLabel,
                value: user?.displayCredits ?? "--",
                icon: Icons.menu_book,
                iconColor: context.colorScheme.secondary,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: ProfileStatCard(
                title: context.l10n.semester,
                value: user?.displayLevel ?? "--",
                icon: Icons.calendar_month,
                iconColor: AppColors.aiPink,
              ),
            ),
          ],
        );
      },
    );
  }
}
