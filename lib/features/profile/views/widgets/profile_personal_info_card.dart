import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePersonalInfoCard extends StatelessWidget {
  const ProfilePersonalInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, state) {
        final user = state is CurrentUserLoaded ? state.user : null;
        return _PersonalInfoContent(user: user);
      },
    );
  }
}

class _PersonalInfoContent extends StatelessWidget {
  const _PersonalInfoContent({required this.user});

  final CurrentUserModel? user;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colors.border, width: 2.w),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.profileInformation,
              style: AppTextStyles.heading2PoppinsSb18.responsive,
            ),
            SizedBox(height: 16.w),
            _InfoRow(
              icon: Icons.badge_outlined,
              label: context.l10n.studentCode,
              value: user?.studentCode?.isNotEmpty == true
                  ? user!.studentCode!
                  : '--',
            ),
            SizedBox(height: 12.w),
            _InfoRow(
              icon: Icons.email_outlined,
              label: context.l10n.email,
              value: user?.email.isNotEmpty == true ? user!.email : '--',
            ),
            SizedBox(height: 12.w),
            _InfoRow(
              icon: Icons.school_outlined,
              label: context.l10n.department,
              value: user?.departmentFor(Localizations.localeOf(context)) ?? '--',
            ),
            SizedBox(height: 12.w),
            _InfoRow(
              icon: Icons.phone_outlined,
              label: context.l10n.phoneNumber,
              value: user?.displayPhone ?? '--',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Row(
      children: [
        Container(
          width: 38.r,
          height: 38.r,
          decoration: BoxDecoration(
            color: colors.mutedSurface,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, size: 20.r, color: colors.textSecondary),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodyInterRegular12.copyWith(
                  fontSize: 11.sp,
                  color: colors.textMuted,
                ),
              ),
              SizedBox(height: 2.w),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyInterMedium14.copyWith(
                  color: colors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}