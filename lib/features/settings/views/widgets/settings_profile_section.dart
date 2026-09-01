import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';

class SettingsProfileSection extends StatelessWidget {
  const SettingsProfileSection({super.key});

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null && context.mounted) {
      final file = File(pickedFile.path);
      context.read<CurrentUserCubit>().updateProfilePhoto(file);
    }
  }

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
              Row(
                children: [
                  // 👈 الأفاتار المطور مع إضافة زر الكاميرا للتعديل
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 28.r,
                        backgroundColor: context.themeColors.mutedSurface,
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
                                size: 28.r,
                                color: context.themeColors.textMuted,
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => _pickAndUploadImage(context),
                          child: CircleAvatar(
                            radius: 10.r,
                            backgroundColor: context.colorScheme.primary,
                            child: Icon(
                              Icons.camera_alt_rounded,
                              size: 11.r,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.nameFor(Localizations.localeOf(context)) ??
                              '--',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bodyInterRegular12.responsive
                              .copyWith(color: context.themeColors.textPrimary),
                        ),
                        SizedBox(height: 4.w),
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
                ],
              ),
              SizedBox(height: 24.w),
              Divider(color: context.themeColors.border, height: 1),
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
