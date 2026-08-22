import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/routing/session_navigation.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvisorHeader extends StatelessWidget {
  final int? studentCount;
  const AdvisorHeader({super.key, required this.studentCount});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: getIt<AuthRepo>()),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: _handleAuthState,
        builder: (context, state) {
          final isLoggingOut = state is LogoutLoading;

          return BlocBuilder<CurrentUserCubit, CurrentUserState>(
            builder: (context, userState) {
              final user = userState is CurrentUserLoaded
                  ? userState.user
                  : null;

              return _AdvisorHeaderContent(
                user: user,
                isLoggingOut: isLoggingOut,
                studentCount: studentCount?.toString() ?? '0',
              );
            },
          );
        },
      ),
    );
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is LogoutSuccess) {
      AppToast.success(
        context,
        title: 'Logged out',
        description: state.response.message,
      );
      SessionNavigation.signedOut(context);
    }

    if (state is LogoutFailure) {
      AppToast.error(
        context,
        title: 'Logged out locally',
        description: state.failure.message,
      );
      SessionNavigation.signedOut(context);
    }
  }
}

class _AdvisorHeaderContent extends StatelessWidget {
  const _AdvisorHeaderContent({
    required this.user,
    required this.isLoggingOut,
    required this.studentCount,
  });

  final CurrentUserModel? user;
  final bool isLoggingOut;
  final String studentCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.primary),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 14.w, 16.w, 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22.r,
                    backgroundColor: Colors.white24,
                    backgroundImage: user?.profileImageUrl?.isNotEmpty == true
                        ? NetworkImage(user!.profileImageUrl!)
                        : null,
                    child: user?.profileImageUrl?.isNotEmpty == true
                        ? null
                        : Icon(Icons.person, color: Colors.white, size: 24.r),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.nameFor(Localizations.localeOf(context)) ??
                              'Advisor',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.w),
                        Text(
                          user?.departmentFor(
                                Localizations.localeOf(context),
                              ) ??
                              'Academic Advisor',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IgnorePointer(
                    ignoring: isLoggingOut,
                    child: GestureDetector(
                      onTap: () => context.read<AuthCubit>().logout(),
                      child: Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        alignment: Alignment.center,
                        child: isLoggingOut
                            ? SizedBox(
                                width: 16.w,
                                height: 16.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : Icon(
                                Icons.logout_rounded,
                                color: Colors.white,
                                size: 18.r,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.w),
              Row(
                children: [
                  statCard(
                    icon: Icons.people_outline,
                  value: user?.studentsCount.toString() ?? '--',
                    // value: studentCount.toString(),
                    label: 'Students',
                  ),
                  const SizedBox(width: 12),
                  statCard(
                    icon: Icons.assignment_outlined,
                    value: user?.displayPendingRequestsCount ?? '--',
                    label: 'Pending',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.w),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.white, size: 20.r),
            SizedBox(height: 6.w),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: AppTextStyles.bodyInterRegular12.copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
