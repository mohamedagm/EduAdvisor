import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/features/advisor_nav/advisor_home_screen.dart';
import 'package:edu_advisor/features/auth/login/views/advisor_login.dart';
import 'package:edu_advisor/features/auth/login/views/advisor_profile.dart';
import 'package:edu_advisor/features/auth/login/views/choose_user_role.dart';
import 'package:edu_advisor/features/auth/login/views/forgot_password.dart';
import 'package:edu_advisor/features/auth/login/views/student_login.dart';
import 'package:edu_advisor/features/auth/login/views/student_profile.dart';
import 'package:edu_advisor/features/auth/login/views/verfy_code_screen.dart';
import 'package:edu_advisor/features/auth/signup/views/signup_view.dart';
import 'package:edu_advisor/features/main/main_view.dart';
import 'package:edu_advisor/features/onbording/onboarding_view.dart';
import 'package:edu_advisor/features/onbording/splash_view.dart';
import 'package:edu_advisor/features/profile/views/notifications_view.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';
import 'package:edu_advisor/features/requests/views/request_details_screen.dart';
import 'package:edu_advisor/features/services/views/course_recommendations_view.dart';
import 'package:edu_advisor/features/services/views/course_registration_view.dart';
import 'package:edu_advisor/features/services/views/registration_status_view.dart';
import 'package:edu_advisor/features/settings/views/settings_view.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingView(),
    ),
    GoRoute(
      path: AppRoutes.chooseUserRole,
      builder: (context, state) => const ChooseUserRole(),
    ),
    GoRoute(
      path: AppRoutes.studentLogin,
      builder: (context, state) => const StudentLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.advisorLogin,
      builder: (context, state) => const AdvisorLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signup,
      builder: (context, state) {
        final role = state.pathParameters['role'];
        final registerRole = role == RegisterRole.advisor.name
            ? RegisterRole.advisor
            : RegisterRole.student;

        return SignupScreen(registerRole: registerRole);
      },
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: AppRoutes.verifyCode,
      builder: (context, state) => const VerifyCodeScreen(),
    ),
    GoRoute(
      path: AppRoutes.studentProfileSetup,
      builder: (context, state) => const StudentProfile(),
    ),
    GoRoute(
      path: AppRoutes.advisorProfileSetup,
      builder: (context, state) => const AdvisorProfile(),
    ),
    GoRoute(
      path: AppRoutes.studentMain,
      builder: (context, state) => const MainView(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) =>
              CurrentUserCubit(userRepo: UserRepo(apiConsumer: DioConsumer()))
                ..getMe(),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.advisorMain,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.requestDetails,
          builder: (context, state) {
            final request = state.extra;
            if (request is StudentRequest) {
              return RequestDetailsScreen(request: request);
            }

            return const Scaffold(
              body: Center(child: Text('Request data is missing')),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (context, state) => const NotificationsView(),
    ),
    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => const SettingsView(),
    ),
    GoRoute(
      path: AppRoutes.courseRecommendations,
      builder: (context, state) => const CourseRecommendationsView(),
    ),
    GoRoute(
      path: AppRoutes.courseRegistration,
      builder: (context, state) => const CourseRegistrationView(),
    ),
    GoRoute(
      path: AppRoutes.registrationStatus,
      builder: (context, state) => const RegistrationStatusView(),
    ),
  ],
);
