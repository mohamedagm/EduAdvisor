import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/services/data/repo/course_registration_repo.dart';
import 'package:edu_advisor/features/services/manager/registration_status_cubit/registration_status_cubit.dart';
import 'package:edu_advisor/features/services/manager/registration_status_cubit/registration_status_state.dart';
import 'package:edu_advisor/features/services/views/widgets/registration_status_card.dart';
import 'package:edu_advisor/features/services/views/widgets/registration_summary_box.dart';
import 'package:edu_advisor/features/services/views/widgets/service_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      backgroundColor: AppColors.gray50,
      appBar: const ServiceAppBar(
        title: 'Registration Status',
        subtitle: 'Track your course requests',
      ),
      body: BlocBuilder<RegistrationStatusCubit, RegistrationStatusState>(
        builder: (context, state) {
          if (state is RegistrationStatusLoading ||
              state is RegistrationStatusInitial) {
            return const Center(child: CircularProgressIndicator());
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
                        color: AppColors.warningAmberDark,
                        bgColor: AppColors.yellowLight,
                        count: state.pendingCount.toString(),
                        label: 'Pending',
                      ),
                      const SizedBox(width: 12),
                      RegistrationSummaryBox(
                        icon: Icons.check_circle_outline,
                        color: AppColors.successGreenDark,
                        bgColor: AppColors.greenLight,
                        count: state.approvedCount.toString(),
                        label: 'Approved',
                      ),
                      const SizedBox(width: 12),
                      RegistrationSummaryBox(
                        icon: Icons.cancel_outlined,
                        color: AppColors.errorRed,
                        bgColor: AppColors.redLight,
                        count: state.rejectedCount.toString(),
                        label: 'Rejected',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'All Registrations',
                    style: AppTextStyles.heading1_20b.copyWith(
                      fontSize: 16,
                      color: AppColors.gray900,
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

class _EmptyRegistrationRequests extends StatelessWidget {
  const _EmptyRegistrationRequests();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray200),
      ),
      child: Text(
        'No registration requests yet.',
        textAlign: TextAlign.center,
        style: AppTextStyles.bodyInterMedium14.copyWith(
          color: AppColors.gray500,
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
            const Icon(Icons.error_outline, color: AppColors.errorRed),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyInterMedium14.copyWith(
                color: AppColors.gray600,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: context
                  .read<RegistrationStatusCubit>()
                  .getRegistrationRequests,
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
