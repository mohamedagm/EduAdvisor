import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      decoration: const BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.myProfile,
                style: AppTextStyles.heading1_20b.copyWith(
                  color: AppColors.white,
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
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),

                  IconButton(
                    onPressed: () {
                      context.push(AppRoutes.settings);
                    },
                    icon: Icon(
                      Icons.settings,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.white,
                child: user?.profileImageUrl?.isNotEmpty == true
                    ? ClipOval(
                        child: SizedBox.expand(
                          child: AppShimmerNetworkImage(
                            imageUrl: user!.profileImageUrl!,
                          ),
                        ),
                      )
                    : const Icon(Icons.person, size: 40),
              ),

              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.displayName ?? context.l10n.student,
                    style: AppTextStyles.heading3PoppinsReg16.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    context.l10n.profileStudentId(user?.displayId ?? '--'),
                    style: AppTextStyles.bodyInterMedium14.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Chip(
                    backgroundColor: context.themeColors.info.withValues(
                      alpha: 0.8,
                    ),
                    label: Text(
                      user?.displayDepartment ?? context.l10n.department,
                      style: AppTextStyles.bodyInterRegular12.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: const BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.myProfile,
                style: AppTextStyles.heading1_20b.copyWith(
                  color: AppColors.white,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.push(AppRoutes.notifications),
                    icon: const Icon(
                      Icons.notifications_none,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: () => context.push(AppRoutes.settings),
                    icon: const Icon(Icons.settings, color: AppColors.white),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          AppShimmer(
            baseColor: Colors.white.withValues(alpha: 0.24),
            highlightColor: Colors.white.withValues(alpha: 0.52),
            child: const Row(
              children: [
                AppShimmerBox(width: 70, height: 70, shape: BoxShape.circle),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmerBox(width: 140, height: 17),
                      SizedBox(height: 8),
                      AppShimmerBox(width: 104, height: 14),
                      SizedBox(height: 8),
                      AppShimmerBox(width: 120, height: 30, borderRadius: 16),
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
