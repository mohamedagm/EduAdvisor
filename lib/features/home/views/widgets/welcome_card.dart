import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        if (state is CurrentUserInitial || state is CurrentUserLoading) {
          return const _WelcomeCardShimmer();
        }

        final user = state is CurrentUserLoaded ? state.user : null;

        return _WelcomeCardContent(user: user);
      },
    );
  }
}

class _WelcomeCardContent extends StatelessWidget {
  const _WelcomeCardContent({required this.user});

  final CurrentUserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 12.r,
            offset: Offset(0, 6.w),
          ),
        ],
      ),
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.white,
                child: user?.profileImageUrl?.isNotEmpty == true
                    ? ClipOval(
                        child: SizedBox.expand(
                          child: AppShimmerNetworkImage(
                            imageUrl: user!.profileImageUrl!,
                          ),
                        ),
                      )
                    : Icon(Icons.person, size: 30.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.welcomeBackName(
                        user?.nameFor(Localizations.localeOf(context)) ??
                            context.l10n.student,
                      ),
                      style: AppTextStyles.heading1_20b.copyWith(
                        fontSize: 20.sp,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.notifications_none,
                  size: 24.r,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.w),

          // Stats Row
          Row(
            spacing: 8.w,
            children: [
              Expanded(
                child: _StatItem(
                  icon: Icons.school_outlined,
                  label: context.l10n.gpa,
                  value: user?.displayGpa ?? '--',
                ),
              ),
              Expanded(
                child: _StatItem(
                  icon: Icons.menu_book_outlined,
                  label: context.l10n.creditsLabel,
                  value: user?.displayCredits ?? '--',
                ),
              ),
              Expanded(
                child: _StatItem(
                  icon: Icons.trending_up,
                  label: context.l10n.level,
                  value: user?.displayLevel ?? '--',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WelcomeCardShimmer extends StatelessWidget {
  const _WelcomeCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 12.r,
            offset: Offset(0, 6.w),
          ),
        ],
      ),
      child: AppShimmer(
        baseColor: Colors.white.withValues(alpha: 0.24),
        highlightColor: Colors.white.withValues(alpha: 0.52),
        child: Column(
          children: [
            Row(
              children: [
                AppShimmerBox(
                  width: 56.r,
                  height: 56.r,
                  shape: BoxShape.circle,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmerBox(width: 132.w, height: 18.w),
                      SizedBox(height: 8.w),
                      AppShimmerBox(width: 104.w, height: 16.w),
                    ],
                  ),
                ),
                AppShimmerBox(
                  width: 36.r,
                  height: 36.r,
                  shape: BoxShape.circle,
                ),
              ],
            ),
            SizedBox(height: 16.w),
            Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: AppShimmerBox(height: 58.w, borderRadius: 12.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.white, size: 14.r),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.w),
          Text(
            value,
            style: AppTextStyles.poppinsRegular14.copyWith(
              fontSize: 14.sp,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
