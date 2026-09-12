import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/services/data/repo/course_registration_repo.dart';
import 'package:edu_advisor/features/services/manager/registration_status_cubit/registration_status_cubit.dart';
import 'package:edu_advisor/features/services/manager/registration_status_cubit/registration_status_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileRegistrationStatusCard extends StatelessWidget {
  const ProfileRegistrationStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegistrationStatusCubit(repo: getIt<CourseRegistrationRepo>())
            ..getRegistrationRequests(),
      child: BlocBuilder<RegistrationStatusCubit, RegistrationStatusState>(
        builder: (context, state) {
          if (state is RegistrationStatusLoading ||
              state is RegistrationStatusInitial) {
            return const _StatusShimmer();
          }

          if (state is RegistrationStatusFailure) {
            return _StatusError(message: state.failure.message);
          }

          if (state is RegistrationStatusLoaded) {
            return _StatusContents(state: state);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

enum _RegistrationState {
  none,
  pending,
  approved,
  rejected,
}

class _StatusContents extends StatelessWidget {
  const _StatusContents({required this.state});

  final RegistrationStatusLoaded state;

  _RegistrationState get _activeState {
    if (state.pendingCount > 0) return _RegistrationState.pending;
    if (state.approvedCount > 0) return _RegistrationState.approved;
    if (state.rejectedCount > 0) return _RegistrationState.rejected;
    return _RegistrationState.none;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final active = _activeState;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Material(
        color: colors.card,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () => context.push(AppRoutes.registrationStatus),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: colors.border, width: 2.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        context.l10n.registrationStatusTitle,
                        style: AppTextStyles.heading2PoppinsSb18.responsive,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 22.r,
                      color: colors.textMuted,
                    ),
                  ],
                ),
                SizedBox(height: 14.w),
                Row(
                  children: [
                    _StatusBox(
                      icon: Icons.access_time,
                      count: state.pendingCount,
                      label: context.l10n.pending,
                      active: active == _RegistrationState.pending,
                    ),
                    SizedBox(width: 8.w),
                    _StatusBox(
                      icon: Icons.check_circle_outline,
                      count: state.approvedCount,
                      label: context.l10n.approved,
                      active: active == _RegistrationState.approved,
                    ),
                    SizedBox(width: 8.w),
                    _StatusBox(
                      icon: Icons.cancel_outlined,
                      count: state.rejectedCount,
                      label: context.l10n.rejected,
                      active: active == _RegistrationState.rejected,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBox extends StatelessWidget {
  const _StatusBox({
    required this.icon,
    required this.count,
    required this.label,
    required this.active,
  });

  final IconData icon;
  final int count;
  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    final Color color;
    final Color bgColor;
    final Color borderColor;

    if (!active) {
      color = colors.textMuted.withValues(alpha: 0.55);
      bgColor = colors.mutedSurface;
      borderColor = colors.border;
    } else if (icon == Icons.access_time) {
      color = colors.warning;
      bgColor = colors.warningContainer;
      borderColor = colors.warning.withValues(alpha: 0.3);
    } else if (icon == Icons.check_circle_outline) {
      color = colors.success;
      bgColor = colors.successContainer;
      borderColor = colors.success.withValues(alpha: 0.3);
    } else {
      color = context.colorScheme.error;
      bgColor = colors.dangerContainer;
      borderColor = context.colorScheme.error.withValues(alpha: 0.3);
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.w),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20.r),
            SizedBox(height: 6.w),
            Text(
              '$count',
              style: AppTextStyles.heading1_20b.copyWith(
                fontSize: 18.sp,
                color: color,
              ),
            ),
            SizedBox(height: 2.w),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.bodyInterRegular12.copyWith(
                fontSize: 11.sp,
                color: active ? color : colors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusShimmer extends StatelessWidget {
  const _StatusShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: AppShimmer(
        child: AppShimmerBox(height: 132.w, borderRadius: 14.r),
      ),
    );
  }
}

class _StatusError extends StatelessWidget {
  const _StatusError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: colors.border, width: 2.w),
        ),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              size: 22.r,
              color: context.colorScheme.error,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ),
            TextButton(
              onPressed: () =>
                  context.read<RegistrationStatusCubit>().getRegistrationRequests(),
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}