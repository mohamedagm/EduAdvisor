import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        if (state is CurrentUserInitial || state is CurrentUserLoading) {
          return const _ProfileHeaderShimmer();
        }

        final user = state is CurrentUserLoaded ? state.user : null;

        return _ProfileHeaderContent(user: user);
      },
    );
  }
}

class _ProfileHeaderContent extends StatelessWidget {
  const _ProfileHeaderContent({required this.user});

  final CurrentUserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.l10n.myProfile,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading1_20b.responsive.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.push(AppRoutes.notifications);
                    },
                    icon: Icon(
                      Icons.notifications_none,
                      color: AppColors.white,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 4.w),

                  IconButton(
                    onPressed: () {
                      context.push(AppRoutes.settings);
                    },
                    icon: Icon(
                      Icons.settings,
                      color: AppColors.white,
                      size: 24.r,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 24.w),

          Row(
            children: [
              CircleAvatar(
                radius: 35.r,
                backgroundColor: AppColors.white,
                child: user?.profileImageUrl?.isNotEmpty == true
                    ? ClipOval(
                        child: SizedBox.expand(
                          child: AppShimmerNetworkImage(
                            imageUrl: user!.profileImageUrl!,
                          ),
                        ),
                      )
                    : Icon(Icons.person, size: 40.r),
              ),

              SizedBox(width: 16.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.nameFor(Localizations.localeOf(context)) ??
                          context.l10n.student,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.heading3PoppinsReg16.responsive
                          .copyWith(color: AppColors.white),
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      context.l10n.profileStudentId(user?.displayId ?? '--'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodyInterMedium14.responsive
                          .copyWith(color: AppColors.white),
                    ),
                    SizedBox(height: 6.w),
                    Chip(
                      backgroundColor: context.themeColors.info.withValues(
                        alpha: 0.8,
                      ),
                      label: Text(
                        user?.departmentFor(Localizations.localeOf(context)) ??
                            context.l10n.department,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodyInterRegular12.responsive
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileHeaderShimmer extends StatelessWidget {
  const _ProfileHeaderShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  context.l10n.myProfile,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.heading1_20b.responsive.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.push(AppRoutes.notifications),
                    icon: Icon(
                      Icons.notifications_none,
                      color: AppColors.white,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  IconButton(
                    onPressed: () => context.push(AppRoutes.settings),
                    icon: Icon(
                      Icons.settings,
                      size: 24.r,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24.w),
          AppShimmer(
            baseColor: Colors.white.withValues(alpha: 0.24),
            highlightColor: Colors.white.withValues(alpha: 0.52),
            child: Row(
              children: [
                AppShimmerBox(
                  width: 70.r,
                  height: 70.r,
                  shape: BoxShape.circle,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmerBox(width: 140.w, height: 17.w),
                      SizedBox(height: 8.w),
                      AppShimmerBox(width: 104.w, height: 14.w),
                      SizedBox(height: 8.w),
                      AppShimmerBox(
                        width: 120.w,
                        height: 30.w,
                        borderRadius: 16.r,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
