import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                    size: 24.r,
                    color: context.colorScheme.primary,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      context.l10n.profileInformation,
                      style: AppTextStyles.bodyInterMedium18.responsive
                          .copyWith(color: context.themeColors.textPrimary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.w),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: context.themeColors.border),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.r,
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
                              size: 24.r,
                              color: context.themeColors.textMuted,
                            ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.nameFor(Localizations.localeOf(context)) ??
                                '--',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyInterMedium14.responsive
                                .copyWith(
                                  color: context.themeColors.textPrimary,
                                ),
                          ),
                          SizedBox(height: 2.w),
                          Text(
                            user?.email ?? '--',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyInterRegular12.responsive
                                .copyWith(color: context.themeColors.textMuted),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Icons.chevron_left
                          : Icons.chevron_right,
                      color: context.themeColors.textMuted,
                      size: 24.r,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.w),
              SettingsInfoRow(
                icon: Icons.mail_outline,
                title: context.l10n.email,
                subtitle: user?.email ?? '--',
              ),
              SizedBox(height: 16.w),
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
              Icon(
                Icons.person_outline,
                size: 24.r,
                color: context.colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  context.l10n.profileInformation,
                  style: AppTextStyles.bodyInterMedium18.responsive.copyWith(
                    color: context.themeColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          AppShimmer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppShimmerBox(height: 66.w, borderRadius: 12.r),
                SizedBox(height: 18.w),
                Row(
                  children: [
                    AppShimmerBox(
                      width: 24.r,
                      height: 24.r,
                      shape: BoxShape.circle,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(width: 58.w, height: 14.w),
                          SizedBox(height: 6.w),
                          AppShimmerBox(width: 164.w, height: 12.w),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18.w),
                Row(
                  children: [
                    AppShimmerBox(
                      width: 24.r,
                      height: 24.r,
                      shape: BoxShape.circle,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppShimmerBox(width: 96.w, height: 14.w),
                          SizedBox(height: 6.w),
                          AppShimmerBox(width: 120.w, height: 12.w),
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
