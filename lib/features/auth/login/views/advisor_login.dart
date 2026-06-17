import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/auth/data/models/login_request_model.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:edu_advisor/features/auth/signup/views/signup_view.dart';
import 'package:edu_advisor/features/auth/widgets/auth_card.dart';
import 'package:edu_advisor/features/auth/widgets/login_form.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdvisorLoginScreen extends StatefulWidget {
  const AdvisorLoginScreen({super.key});

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
            backgroundColor: AppColors.gray100,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  const GradiantContainer(
                    mainText: 'Your Academic Success Partner',
                  ),
                  AuthCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'Login as Advisor',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        LoginForm(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              context.push(AppRoutes.forgotPassword);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.deepPurple.shade400,
                              visualDensity: VisualDensity.compact,
                            ),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        IgnorePointer(
                          ignoring: isLoading,
                          child: Opacity(
                            opacity: isLoading ? 0.75 : 1,
                            child: SizedBox(
                              width: double.infinity,
                              child: GradientElevatedButton(
                                buttonText: isLoading
                                    ? 'Logging in...'
                                    : 'Login as advisor',
                                onPressed: () => _onLoginPressed(
                                  context,
                                  isLoading: isLoading,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: AppTextStyles.interRegular16.copyWith(
                                color: AppColors.gray600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.push(
                                AppRoutes.signupFor(RegisterRole.advisor.name),
                              ),
                              child: Text(
                                'Sign Up',
                                style: AppTextStyles.bodyInterMedium18.copyWith(
                                  color: AppColors.infoBlue,
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
        title: 'Login Successful',
        description: 'Welcome back, ${state.response.user.fullName}',
      );
      context.go(AppRoutes.advisorProfileSetup);
    }

    if (state is LoginFailure) {
      AppToast.error(
        context,
        title: 'Login Failed',
        description: state.failure.message,
      );
    }
  }

  void _onLoginPressed(BuildContext context, {required bool isLoading}) {
    if (isLoading || !_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthCubit>().login(
      LoginRequestModel(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
      expectedRole: 'Advisor',
    );
  }
}
