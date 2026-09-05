import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_shimmer.dart';
import 'package:edu_advisor/features/advisor_nav/data/repo/advisor_repo.dart';
import 'package:edu_advisor/features/advisor_nav/manger/cubit/my_students_cubit.dart';
import 'package:edu_advisor/features/advisor_nav/manger/cubit/my_students_state.dart';
import 'package:edu_advisor/features/analytics/manager/dashboard_cubit.dart';
import 'package:edu_advisor/features/analytics/widgets/performance_card.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';

class AdvisorAnalytics extends StatelessWidget {
  const AdvisorAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DashboardCubit(repo: getIt<AdvisorRepo>())..fetchDashboard(),
      child: const _AdvisorAnalyticsBody(),
    );
  }
}

class _AdvisorAnalyticsBody extends StatelessWidget {
  const _AdvisorAnalyticsBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<MyStudentsCubit, MyStudentsState>(
              builder: (context, state) {
                final count = state is MyStudentsSuccess ? state.totalCount : 0;
                return AdvisorHeader(studentCount: count);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.analyticsAndReports,
                      style: AppTextStyles.heading3PoppinsReg16.copyWith(
                        color: context.themeColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 12.w),
                    BlocBuilder<DashboardCubit, DashboardState>(
                      builder: (context, state) {
                        if (state is DashboardLoading ||
                            state is DashboardInitial) {
                          return const _DashboardShimmer();
                        }

                        if (state is DashboardFailure) {
                          return Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: context.themeColors.dangerContainer,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Text(
                              state.failure.message,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.bodyInterMedium14.copyWith(
                                color: context.themeColors.onDangerContainer,
                              ),
                            ),
                          );
                        }

                        if (state is DashboardLoaded) {
                          final dashboard = state.dashboard;

                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _StatBox(
                                      icon: Icons.people_outline,
                                      value: dashboard.totalStudents.toString(),
                                      label: context.l10n.totalStudents,
                                      color: context.colorScheme.primary,
                                      bg: context.themeColors.mutedSurface,
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: _StatBox(
                                      icon: Icons.assignment_outlined,
                                      value: dashboard
                                          .pendingRegistrationRequests
                                          .toString(),
                                      label: context.l10n.pendingRequests,
                                      color: context.themeColors.warning,
                                      bg: context.themeColors.warningContainer,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.w),
                              PerformanceCard(
                                distribution: dashboard.gpaDistribution,
                              ),
                            ],
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.bg,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24.r),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: context.themeColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardShimmer extends StatelessWidget {
  const _DashboardShimmer();

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppShimmerBox(height: 70.w, borderRadius: 16.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: AppShimmerBox(height: 70.w, borderRadius: 16.r),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          AppShimmerBox(height: 180.w, borderRadius: 16.r),
        ],
      ),
    );
  }
}
