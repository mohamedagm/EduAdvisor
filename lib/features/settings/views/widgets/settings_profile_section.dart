import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsProfileSection extends StatelessWidget {
  const SettingsProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        final user = state is CurrentUserLoaded ? state.user : null;

        return SettingsCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.person_outline,
                    color: AppColors.bluePrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Profile Information',
                    style: AppTextStyles.bodyInterMedium18.copyWith(
                      color: AppColors.gray800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.gray50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.gray200),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.gray200,
                      backgroundImage: user?.profileImageUrl?.isNotEmpty == true
                          ? NetworkImage(user!.profileImageUrl!)
                          : null,
                      child: user?.profileImageUrl?.isNotEmpty == true
                          ? null
                          : const Icon(Icons.person, color: AppColors.gray500),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.displayName ?? '--',
                            style: AppTextStyles.bodyInterMedium14.copyWith(
                              color: AppColors.gray900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            user?.email ?? '--',
                            style: AppTextStyles.bodyInterRegular12.copyWith(
                              color: AppColors.gray500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: AppColors.gray400),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SettingsInfoRow(
                icon: Icons.mail_outline,
                title: 'Email',
                subtitle: user?.email ?? '--',
              ),
              const SizedBox(height: 16),
              SettingsInfoRow(
                icon: Icons.smartphone_outlined,
                title: 'Phone Number',
                subtitle: user?.displayPhone ?? '--',
              ),
            ],
          ),
        );
      },
    );
  }
}
