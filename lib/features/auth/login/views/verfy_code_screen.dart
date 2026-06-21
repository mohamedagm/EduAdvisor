import 'dart:async';
import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/reset_password_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/verify_code_state.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/reset_password_repo.dart';
import 'package:edu_advisor/features/auth/login/views/new_pass.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  int resendCountdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());

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
    _timer?.cancel();
    super.dispose();
  }

  String get otpCode => controllers.map((c) => c.text.trim()).join();

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < otpLength - 1) {
      focusNodes[index + 1].requestFocus();
    }

    if (value.length > 1) {
      for (int i = 0; i < value.length && i < otpLength; i++) {
        controllers[i].text = value[i];
      }
    }

    setState(() {});
  }

  void submitOtpVerification() {
    if (otpCode.length != otpLength) {
      AppToast.warning(
        context,
        title: context.l10n.incompleteCode,
        description: context.l10n.completeVerificationCode,
      );
      return;
    }

    context.read<VerifyCodeCubit>().verifyOtp(
      email: widget.email,
      code: otpCode,
      isFromForgotPassword: widget.isFromForgotPassword,
    );
  }

  void handleResendCode() {
    if (resendCountdown > 0) return;

    context.read<VerifyCodeCubit>().resendOtp(email: widget.email);
  }

  void startTimer() {
    setState(() {
      resendCountdown = 30;

      for (var c in controllers) {
        c.clear();
      }
    });

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      setState(() {
        resendCountdown--;

        if (resendCountdown <= 0) {
          timer.cancel();
        }
      });
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) focusNodes[0].requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VerifyCodeCubit, VerifyCodeState>(
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
            if (mounted) {
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
                        token: state.response.data ?? '',
                      ),
                    ),
                  ),
                );
              }
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
                        token: state.response.data ?? '',
                      ),
                    ),
                  ),
                );
              }
            }
            if (!context.mounted || !widget.isFromForgotPassword) return;
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
                    token: state.response.data ?? '',
                  ),
                ),
              ),
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
          startTimer();

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
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(otpLength, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 40,
                            height: 56,
                            child: TextField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              enabled: !isLoading,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              decoration: const InputDecoration(
                                counterText: '',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) => onOtpChanged(index, value),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: (resendCountdown == 0 && !isLoading)
                            ? handleResendCode
                            : null,
                        child: Text(
                          resendCountdown > 0
                              ? context.l10n.resendIn(resendCountdown)
                              : context.l10n.resendCode,
                        ),
                      ),

                      const SizedBox(height: 30),

                      ElevatedButton(
                        onPressed: isLoading ? null : submitOtpVerification,
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
    );
  }
}
