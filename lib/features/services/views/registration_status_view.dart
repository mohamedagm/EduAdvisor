import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/services/data/repo/course_registration_repo.dart';
import 'package:edu_advisor/features/services/manager/registration_status_cubit/registration_status_cubit.dart';
import 'package:edu_advisor/features/services/manager/registration_status_cubit/registration_status_state.dart';
import 'package:edu_advisor/features/services/views/widgets/registration_status_card.dart';
import 'package:edu_advisor/features/services/views/widgets/registration_summary_box.dart';
import 'package:edu_advisor/features/services/views/widgets/service_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationStatusView extends StatelessWidget {
  const RegistrationStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          RegistrationStatusCubit(repo: getIt<CourseRegistrationRepo>())
            ..getRegistrationRequests(),
      child: const _RegistrationStatusBody(),
    );
  }
}

class _RegistrationStatusBody extends StatelessWidget {
  const _RegistrationStatusBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      appBar: ServiceAppBar(
        title: context.l10n.registrationStatusTitle,
        subtitle: context.l10n.trackCourseRequests,
      ),
      body: BlocBuilder<RegistrationStatusCubit, RegistrationStatusState>(
        builder: (context, state) {
          if (state is RegistrationStatusLoading ||
              state is RegistrationStatusInitial) {
            return const _RegistrationStatusShimmer();
          }

          if (state is RegistrationStatusFailure) {
            return _RegistrationStatusError(message: state.failure.message);
          }

          if (state is RegistrationStatusLoaded) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RegistrationSummaryBox(
                        icon: Icons.access_time,
                        color: context.themeColors.warning,
                        bgColor: context.themeColors.warningContainer,
                        count: state.pendingCount.toString(),
                        label: context.l10n.pending,
                      ),
                      SizedBox(width: 12.w),
                      RegistrationSummaryBox(
                        icon: Icons.check_circle_outline,
                        color: context.themeColors.success,
                        bgColor: context.themeColors.successContainer,
                        count: state.approvedCount.toString(),
                        label: context.l10n.approved,
                      ),
                      SizedBox(width: 12.w),
                      RegistrationSummaryBox(
                        icon: Icons.cancel_outlined,
                        color: context.colorScheme.error,
                        bgColor: context.themeColors.dangerContainer,
                        count: state.rejectedCount.toString(),
                        label: context.l10n.rejected,
                      ),
                    ],
                  ),
                  SizedBox(height: 24.w),
                  Text(
                    context.l10n.allRegistrations,
                    style: AppTextStyles.heading1_20b.copyWith(
                      fontSize: 16.sp,
                      color: context.themeColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 16.w),
                  if (state.requests.isEmpty)
                    const _EmptyRegistrationRequests()
                  else
                    ...state.requests.map(
                      (request) => Padding(
                        padding: EdgeInsets.only(bottom: 16.w),
                        child: RegistrationStatusCard(request: request),
                      ),
                    ),
                  SizedBox(height: 16.w),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _RegistrationStatusShimmer extends StatelessWidget {
  const _RegistrationStatusShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      physics: const NeverScrollableScrollPhysics(),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                3,
                (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: AppShimmerBox(height: 96.w, borderRadius: 16.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.w),
            AppShimmerBox(width: 132.w, height: 18.w),
            SizedBox(height: 16.w),
            const _RegistrationStatusSkeletonCard(),
            SizedBox(height: 16.w),
            const _RegistrationStatusSkeletonCard(),
          ],
        ),
      ),
    );
  }
}

class _RegistrationStatusSkeletonCard extends StatelessWidget {
  const _RegistrationStatusSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppShimmerBox(width: 20.r, height: 20.r, shape: BoxShape.circle),
              SizedBox(width: 8.w),
              AppShimmerBox(width: 76.w, height: 24.w, borderRadius: 12.r),
            ],
          ),
          SizedBox(height: 20.w),
          AppShimmerBox(height: 14.w),
          SizedBox(height: 12.w),
          AppShimmerBox(width: 220.w, height: 14.w),
          SizedBox(height: 12.w),
          AppShimmerBox(width: 180.w, height: 14.w),
          SizedBox(height: 20.w),
          Divider(height: 1.w, color: context.themeColors.border),
          SizedBox(height: 16.w),
          Row(
            children: [
              AppShimmerBox(width: 32.r, height: 32.r, shape: BoxShape.circle),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBox(width: 126.w, height: 14.w),
                    SizedBox(height: 6.w),
                    AppShimmerBox(width: 98.w, height: 12.w),
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

class _EmptyRegistrationRequests extends StatelessWidget {
  const _EmptyRegistrationRequests();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Text(
        context.l10n.noRegistrationRequests,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
          color: context.themeColors.textMuted,
        ),
      ),
    );
  }
}

class _RegistrationStatusError extends StatelessWidget {
  const _RegistrationStatusError({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 24.r,
              color: context.colorScheme.error,
            ),
            SizedBox(height: 8.w),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
            SizedBox(height: 8.w),
            TextButton(
              onPressed: context
                  .read<RegistrationStatusCubit>()
                  .getRegistrationRequests,
              child: Text(context.l10n.retry),
            ),
          ],
        ),
      ),
    );
  }
}
