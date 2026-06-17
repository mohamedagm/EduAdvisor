import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdvisorHeader extends StatelessWidget {
  const AdvisorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(authRepo: AuthRepo(apiConsumer: DioConsumer())),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: _handleAuthState,
        builder: (context, state) {
          final isLoggingOut = state is LogoutLoading;

          return Container(
            decoration: BoxDecoration(gradient: AppGradients.primary),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        //handle profile immage and name
                        // const CircleAvatar(
                        //   radius: 22,
                        //   backgroundImage:
                        //       AssetImage('assets/images/avatar.png'),
                        // ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dr. Hebatulla Nabil',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Academic Advisor',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
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
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: isLoggingOut
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.logout_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        statCard(
                          icon: Icons.people_outline,
                          value: '45',
                          label: 'Students',
                        ),
                        const SizedBox(width: 12),
                        statCard(
                          icon: Icons.assignment_outlined,
                          value: '22',
                          label: 'Requests',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
      context.go(AppRoutes.chooseUserRole);
    }

    if (state is LogoutFailure) {
      AppToast.error(
        context,
        title: 'Logged out locally',
        description: state.failure.message,
      );
      context.go(AppRoutes.chooseUserRole);
    }
  }

  Widget statCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.white, size: 20),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
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
