import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
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

class RegistrationStatusView extends StatelessWidget {
  const RegistrationStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationStatusCubit(
        repo: CourseRegistrationRepo(apiConsumer: DioConsumer()),
      )..getRegistrationRequests(),
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
              padding: const EdgeInsets.all(16),
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
                      const SizedBox(width: 12),
                      RegistrationSummaryBox(
                        icon: Icons.check_circle_outline,
                        color: context.themeColors.success,
                        bgColor: context.themeColors.successContainer,
                        count: state.approvedCount.toString(),
                        label: context.l10n.approved,
                      ),
                      const SizedBox(width: 12),
                      RegistrationSummaryBox(
                        icon: Icons.cancel_outlined,
                        color: context.colorScheme.error,
                        bgColor: context.themeColors.dangerContainer,
                        count: state.rejectedCount.toString(),
                        label: context.l10n.rejected,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    context.l10n.allRegistrations,
                    style: AppTextStyles.heading1_20b.copyWith(
                      fontSize: 16,
                      color: context.themeColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (state.requests.isEmpty)
                    const _EmptyRegistrationRequests()
                  else
                    ...state.requests.map(
                      (request) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: RegistrationStatusCard(request: request),
                      ),
                    ),
                  const SizedBox(height: 16),
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
      padding: const EdgeInsets.all(16),
      physics: const NeverScrollableScrollPhysics(),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                3,
                (index) => const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: AppShimmerBox(height: 96, borderRadius: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const AppShimmerBox(width: 132, height: 18),
            const SizedBox(height: 16),
            const _RegistrationStatusSkeletonCard(),
            const SizedBox(height: 16),
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppShimmerBox(width: 20, height: 20, shape: BoxShape.circle),
              SizedBox(width: 8),
              AppShimmerBox(width: 76, height: 24, borderRadius: 12),
            ],
          ),
          SizedBox(height: 20),
          AppShimmerBox(height: 14),
          SizedBox(height: 12),
          AppShimmerBox(width: 220, height: 14),
          SizedBox(height: 12),
          AppShimmerBox(width: 180, height: 14),
          SizedBox(height: 20),
          Divider(height: 1, color: context.themeColors.border),
          SizedBox(height: 16),
          Row(
            children: [
              AppShimmerBox(width: 32, height: 32, shape: BoxShape.circle),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppShimmerBox(width: 126, height: 14),
                    SizedBox(height: 6),
                    AppShimmerBox(width: 98, height: 12),
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.themeColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Text(
        context.l10n.noRegistrationRequests,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyInterMedium14.copyWith(
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
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: context.colorScheme.error),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: context.themeColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
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
