import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.bluePrimary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.white,
                child: user?.profileImageUrl?.isNotEmpty == true
                    ? ClipOval(
                        child: SizedBox.expand(
                          child: AppShimmerNetworkImage(
                            imageUrl: user!.profileImageUrl!,
                          ),
                        ),
                      )
                    : const Icon(Icons.person, size: 30),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back,',
                      style: AppTextStyles.heading1_20b.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      user?.displayName ?? 'Student',
                      style: AppTextStyles.bodyInterMedium18.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none, color: Colors.white),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                icon: Icons.school_outlined,
                label: 'GPA',
                value: user?.displayGpa ?? '--',
              ),
              _StatItem(
                icon: Icons.menu_book_outlined,
                label: 'Credits',
                value: user?.displayCredits ?? '--',
              ),
              _StatItem(
                icon: Icons.trending_up,
                label: 'Level',
                value: user?.displayLevel ?? '--',
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.bluePrimary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: AppShimmer(
        baseColor: Colors.white.withValues(alpha: 0.24),
        highlightColor: Colors.white.withValues(alpha: 0.52),
        child: Column(
          children: [
            const Row(
              children: [
                AppShimmerBox(width: 56, height: 56, shape: BoxShape.circle),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmerBox(width: 132, height: 18),
                      SizedBox(height: 8),
                      AppShimmerBox(width: 104, height: 16),
                    ],
                  ),
                ),
                AppShimmerBox(width: 36, height: 36, shape: BoxShape.circle),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: List.generate(
                3,
                (index) => const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: AppShimmerBox(height: 58, borderRadius: 12),
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.white, size: 14),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTextStyles.bodyInterRegular12.copyWith(
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.poppinsRegular14.copyWith(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
