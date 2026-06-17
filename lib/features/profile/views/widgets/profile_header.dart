import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
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
                "My Profile",
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
                backgroundImage: user?.profileImageUrl?.isNotEmpty == true
                    ? NetworkImage(user!.profileImageUrl!)
                    : null,
                child: user?.profileImageUrl?.isNotEmpty == true
                    ? null
                    : const Icon(Icons.person, size: 40),
              ),

              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.displayName ?? "Student",
                    style: AppTextStyles.heading3PoppinsReg16.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "ID: ${user?.displayId ?? '--'}",
                    style: AppTextStyles.bodyInterMedium14.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Chip(
                    backgroundColor: AppColors.infoBlue.withValues(alpha: 0.8),
                    label: Text(
                      user?.displayDepartment ?? "Department",
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
