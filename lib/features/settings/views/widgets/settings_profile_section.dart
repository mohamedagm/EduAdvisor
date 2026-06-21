import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class SettingsProfileSection extends StatelessWidget {
  const SettingsProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        if (state is CurrentUserInitial || state is CurrentUserLoading) {
          return const _SettingsProfileShimmer();
        }

        final user = state is CurrentUserLoaded ? state.user : null;

        return SettingsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    color: context.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    context.l10n.profileInformation,
                    style: AppTextStyles.bodyInterMedium18.copyWith(
                      color: context.themeColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.themeColors.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: context.themeColors.border,
                      child: user?.profileImageUrl?.isNotEmpty == true
                          ? ClipOval(
                              child: SizedBox.expand(
                                child: AppShimmerNetworkImage(
                                  imageUrl: user!.profileImageUrl!,
                                ),
                              ),
                            )
                          : Icon(
                              Icons.person,
                              color: context.themeColors.textMuted,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? '--',
                            style: AppTextStyles.bodyInterMedium14.copyWith(
                              color: context.themeColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user?.email ?? '--',
                            style: AppTextStyles.bodyInterRegular12.copyWith(
                              color: context.themeColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Icons.chevron_left
                          : Icons.chevron_right,
                      color: context.themeColors.textMuted,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SettingsInfoRow(
                icon: Icons.mail_outline,
                title: context.l10n.email,
                subtitle: user?.email ?? '--',
              ),
              const SizedBox(height: 16),
              SettingsInfoRow(
                icon: Icons.smartphone_outlined,
                title: context.l10n.phoneNumber,
                subtitle: user?.displayPhone ?? '--',
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsProfileShimmer extends StatelessWidget {
  const _SettingsProfileShimmer();

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, color: context.colorScheme.primary),
              const SizedBox(width: 8),
              Text(
                context.l10n.profileInformation,
                style: AppTextStyles.bodyInterMedium18.copyWith(
                  color: context.themeColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const AppShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerBox(height: 66, borderRadius: 12),
                SizedBox(height: 18),
                Row(
                  children: [
                    AppShimmerBox(
                      width: 24,
                      height: 24,
                      shape: BoxShape.circle,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(width: 58, height: 14),
                          SizedBox(height: 6),
                          AppShimmerBox(width: 164, height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  children: [
                    AppShimmerBox(
                      width: 24,
                      height: 24,
                      shape: BoxShape.circle,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(width: 96, height: 14),
                          SizedBox(height: 6),
                          AppShimmerBox(width: 120, height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
