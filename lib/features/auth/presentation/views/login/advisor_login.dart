import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/routing/session_navigation.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/departments_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/data/models/login_request_model.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/departments_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/verify_code_repo.dart';
import 'package:edu_advisor/features/auth/presentation/views/login/forgot_password.dart';
import 'package:edu_advisor/features/auth/presentation/views/login/verfy_code_screen.dart';
import 'package:edu_advisor/features/auth/presentation/views/signup/advisors_signup.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/auth_card.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/login_form.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class AdvisorLoginScreen extends StatefulWidget {
  final RegisterRole registerRole;
  const AdvisorLoginScreen({super.key, required this.registerRole});

  @override
  State<AdvisorLoginScreen> createState() => _AdvisorLoginScreenState();
}

class _AdvisorLoginScreenState extends State<AdvisorLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthCubit(authRepo: AuthRepo(apiConsumer: DioConsumer())),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: _authListener,
        builder: (context, state) {
          final isLoading = state is LoginLoading;

          return Scaffold(
            backgroundColor: context.themeColors.mutedSurface,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  GradiantContainer(
                    mainText: context.l10n.academicSuccessPartner,
                  ),
                  AuthCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.w),
                        Center(
                          child: Text(
                            context.l10n.loginAsAdvisor,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.w),
                        LoginForm(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(
                                        registerRole: RegisterRole.advisor,
                                      ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: context.colorScheme.secondary,
                              visualDensity: VisualDensity.compact,
                            ),
                            child: Text(
                              context.l10n.forgotPassword,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.w),
                        IgnorePointer(
                          ignoring: isLoading,
                          child: Opacity(
                            opacity: isLoading ? 0.75 : 1,
                            child: SizedBox(
                              width: double.infinity,
                              child: GradientElevatedButton(
                                buttonText: isLoading
                                    ? context.l10n.loggingIn
                                    : context.l10n.loginAsAdvisor,
                                onPressed: () => _onLoginPressed(
                                  context,
                                  isLoading: isLoading,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${context.l10n.noAccount} ',
                              style: AppTextStyles.interRegular16.copyWith(
                                fontSize: 16.sp,
                                color: context.themeColors.textSecondary,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (loginContext) => MultiBlocProvider(
                                    providers: [
                                      BlocProvider<AuthCubit>(
                                        create: (context) => AuthCubit(
                                          authRepo: AuthRepo(
                                            apiConsumer: DioConsumer(),
                                          ),
                                        ),
                                      ),
                                      BlocProvider<DepartmentsCubit>(
                                        create: (context) => DepartmentsCubit(
                                          departmentsRepo: DepartmentsRepo(
                                            apiConsumer: DioConsumer(),
                                          ),
                                        )..fetchDepartments(),
                                      ),
                                    ],
                                    child: const AdvisorSignupScreen(
                                      registerRole: RegisterRole.advisor,
                                    ),
                                  ),
                                ),
                              ),
                              child: Text(
                                context.l10n.signUp,
                                style: AppTextStyles.bodyInterMedium18.copyWith(
                                  fontSize: 18.sp,
                                  color: context.themeColors.info,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is LoginSuccess) {
      AppToast.success(
        context,
        title: context.l10n.loginSuccessful,
        description: context.l10n.welcomeBackName(state.response.user.fullName),
      );
      SessionNavigation.advisorSignedIn(context);
    }

    if (state is LoginFailure) {
      final msg = state.failure.message.toLowerCase();

      if (msg.contains("accountnotverified")) {
        // في signup_screen.dart
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => VerifyCodeCubit(
                verifyCodeRepo: VerifyCodeRepo(apiConsumer: DioConsumer()),
              ),
              child: VerifyCodeScreen(
                email: _emailController.text.trim(),
                role: widget.registerRole,
              ),
            ),
          ),
        );
        return;
      }

      AppToast.error(
        context,
        title: context.l10n.loginFailed,
        description: msg.toLowerCase().startsWith('this account is not a')
            ? context.l10n.wrongRoleAccount(context.l10n.advisor)
            : msg,
      );
    }
  }

  void _onLoginPressed(BuildContext context, {required bool isLoading}) {
    if (isLoading || !_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().login(
      LoginRequestModel(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
      expectedRole: 'Advisor',
    );
  }
}
