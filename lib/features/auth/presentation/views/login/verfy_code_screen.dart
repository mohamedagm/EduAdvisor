import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/forgot_password_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/forgot_password_state.dart';
import 'package:edu_advisor/features/auth/data/repo/forgot_password_repo.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/reset_password_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/verify_code_state.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/reset_password_repo.dart';
import 'package:edu_advisor/features/auth/presentation/views/login/new_pass.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/otp_digit_field.dart';
import 'package:edu_advisor/features/auth/presentation/views/login/advisor_login.dart';
import 'package:edu_advisor/features/auth/presentation/views/login/student_login.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;
  final RegisterRole role;
  final bool isFromForgotPassword;

  const VerifyCodeScreen({
    super.key,
    required this.email,
    required this.role,
    this.isFromForgotPassword = false,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final int otpLength = 6;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  late List<FocusNode> keyboardFocusNodes;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    keyboardFocusNodes = List.generate(
      otpLength,
      (_) => FocusNode(skipTraversal: true),
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    for (var f in keyboardFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get otpCode => controllers.map((c) => c.text.trim()).join();

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < otpLength - 1) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }

    if (value.length > 1) {
      for (int i = 0; i < value.length && i < otpLength; i++) {
        controllers[i].text = value[i];
      }
    }

    setState(() {});
  }

  void onBackspaceOnEmptyField(int index) {
    if (index == 0) return;
    focusNodes[index - 1].requestFocus();
    controllers[index - 1].clear();
    setState(() {});
  }

  ///////////////////handle submit otp verification
  void submitOtpVerification(BuildContext context) {
    if (otpCode.length != otpLength) {
      AppToast.warning(
        context,
        title: context.l10n.incompleteCode,
        description: context.l10n.completeVerificationCode,
      );
      return;
    }

    if (widget.isFromForgotPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ResetPasswordCubit(
              resetPasswordRepo: getIt<ResetPasswordRepo>(),
            ),
            child: NewPasswordScreen(
              role: widget.role,
              email: widget.email,
              otp: otpCode,
            ),
          ),
        ),
      );
      return;
    }

    context.read<VerifyCodeCubit>().verifyOtp(
      email: widget.email,
      code: otpCode,
      isFromForgotPassword: widget.isFromForgotPassword,
    );
  }

  void handleResendCode(BuildContext context) {
    if (widget.isFromForgotPassword) {
      context.read<ForgotPasswordCubit>().sendOtp(email: widget.email);
      return;
    }

    context.read<VerifyCodeCubit>().resendOtp(email: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(repo: getIt<ForgotPasswordRepo>()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state is ForgotPasswordSuccess) {
                for (var c in controllers) {
                  c.clear();
                }
                if (mounted) focusNodes[0].requestFocus();

                AppToast.success(
                  context,
                  title: context.l10n.codeSent,
                  description: context.l10n.newVerificationCodeSent,
                );
              }

              if (state is ForgotPasswordFailure) {
                AppToast.error(
                  context,
                  title: context.l10n.couldNotResendCode,
                  description: state.message,
                );
              }
            },
          ),
        ],
        child: BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
          listener: (context, state) {
            if (state is VerifyOtpLoading) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Verifying...")));
            }

            if (state is VerifyOtpSuccess) {
              AppToast.success(
                context,
                title: context.l10n.codeVerified,
                description: context.l10n.verificationCodeAccepted,
              );

              Future.delayed(const Duration(seconds: 1), () {
                if (!context.mounted) return;

                if (widget.isFromForgotPassword) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => ResetPasswordCubit(
                          resetPasswordRepo: getIt<ResetPasswordRepo>(),
                        ),
                        child: NewPasswordScreen(
                          role: widget.role,
                          email: widget.email,
                          otp: otpCode,
                        ),
                      ),
                    ),
                  );
                  return;
                }

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => widget.role == RegisterRole.advisor
                        ? const AdvisorLoginScreen(
                            registerRole: RegisterRole.advisor,
                          )
                        : const StudentLoginScreen(
                            registerRole: RegisterRole.student,
                          ),
                  ),
                  (route) => false,
                );
              });
            }

            if (state is VerifyOtpFailure) {
              debugPrint('VERIFY ERROR: "${state.failure.message}"');
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.failure.message)));
            }

            if (state is ResendOtpSuccess) {
              for (var c in controllers) {
                c.clear();
              }
              if (mounted) focusNodes[0].requestFocus();

              AppToast.success(
                context,
                title: context.l10n.codeSent,
                description: context.l10n.newVerificationCodeSent,
              );
            }

            if (state is ResendOtpFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.failure.message)));
              AppToast.error(
                context,
                title: context.l10n.couldNotResendCode,
                description: state.failure.message,
              );
            }
          },
          builder: (context, state) {
            final isLoading =
                state is VerifyOtpLoading || state is ResendOtpLoading;

            return Scaffold(
              backgroundColor: context.colorScheme.surface,
              body: Column(
                children: [
                  GradiantContainer(
                    mainText: context.l10n.verifyCode,
                    optionalText: context.l10n.checkEmailForCode,
                  ),

                  /////////////otp input fields
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(otpLength, (index) {
                              return OtpDigitField(
                                controller: controllers[index],
                                focusNode: focusNodes[index],
                                keyboardFocusNode: keyboardFocusNodes[index],
                                enabled: !isLoading,
                                onChanged: (value) =>
                                    onOtpChanged(index, value),
                                onBackspaceOnEmpty: () =>
                                    onBackspaceOnEmptyField(index),
                              );
                            }),
                          ),

                          SizedBox(height: 20.w),

                          TextButton(
                            onPressed: isLoading
                                ? null
                                : () => handleResendCode(context),
                            child: Text(context.l10n.resendCode),
                          ),
                          SizedBox(height: 30.w),

                          ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () => submitOtpVerification(context),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : Text(context.l10n.verify),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
