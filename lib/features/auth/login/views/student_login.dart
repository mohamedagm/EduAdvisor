import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/departments_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/data/models/login_request_model.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/departments_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/verify_code_repo.dart';
import 'package:edu_advisor/features/auth/login/views/forgot_password.dart';
import 'package:edu_advisor/features/auth/login/views/verfy_code_screen.dart';
import 'package:edu_advisor/features/auth/signup/views/signup_view.dart';
import 'package:edu_advisor/features/auth/widgets/auth_card.dart';
import 'package:edu_advisor/features/auth/widgets/login_form.dart';
import 'package:edu_advisor/features/main/main_view.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentLoginScreen extends StatefulWidget {
   final RegisterRole registerRole;

  const StudentLoginScreen({super.key, required this.registerRole});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
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
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Login as Student',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF333333),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        LoginForm(
                          formKey: _formKey,
                          emailController: _emailController,
                          passwordController: _passwordController,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ForgotPasswordScreen(
                                        registerRole: RegisterRole.student,
                                      ),
                                ),
                              );
                            },
                            child: const Text('Forgot Password?'),
                          ),
                        ),
                        const SizedBox(height: 24),
                        IgnorePointer(
                          ignoring: isLoading,
                          child: SizedBox(
                            width: double.infinity,
                            child: GradientElevatedButton(
                              buttonText: isLoading
                                  ? 'Logging in...'
                                  : 'Login as student',
                              onPressed: () => _onLoginPressed(
                                context,
                                isLoading: isLoading,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
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
                                      child: const SignupScreen(
                                        registerRole: RegisterRole.student,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Sign Up'),
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

  // ⭐ هنا التعديل الوحيد المهم
  void _authListener(BuildContext context, AuthState state) {
    if (state is LoginSuccess) {
      AppToast.success(
        context,
        title: 'Login Successful',
        description: 'Welcome back, ${state.response.user.fullName}',
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainView(fullName: state.response.user.fullName)),
      );
    }

    if (state is LoginFailure) {
      final msg = state.failure.message.toLowerCase();

     
 if (msg.contains("accountnotverified"))  {
             // في signup_screen.dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => BlocProvider(
      create: (context) => VerifyCodeCubit(
         verifyCodeRepo: VerifyCodeRepo(
           apiConsumer: DioConsumer(),
            
         ),
        
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
        title: 'Login Failed',
        description: state.failure.message,
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
      expectedRole: 'Student',
    );
  }
}