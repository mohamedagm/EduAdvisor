import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/forgot_password_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/forgot_password_state.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/forgot_password_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/verify_code_repo.dart';
import 'package:edu_advisor/features/auth/login/views/verfy_code_screen.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/custom_text_button.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final RegisterRole registerRole;
  const ForgotPasswordScreen({super.key, required this.registerRole});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return BlocProvider(
      create: (context) =>
          ForgotPasswordCubit(repo: getIt<ForgotPasswordRepo>()),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            AppToast.success(
              context,
              title: context.l10n.verificationCodeSent,
              description: state.response.message,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) =>
                      VerifyCodeCubit(verifyCodeRepo: getIt<VerifyCodeRepo>()),
                  child: VerifyCodeScreen(
                    email: _emailController.text.trim(),
                    role: widget.registerRole,
                    isFromForgotPassword: true,
                  ),
                ),
              ),
            );
          }

          if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '${context.l10n.couldNotSendCode}: ${state.message}',
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ForgotPasswordLoading;

          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    GradiantContainer(
                      mainText: context.l10n.forgotPassword,
                      optionalText: context.l10n.forgotPasswordHelp,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: height * 0.41,
                        right: width * 0.03,
                        left: width * 0.03,
                      ),
                      constraints: BoxConstraints(minHeight: height * 0.35),
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: context.themeColors.card,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.themeColors.textPrimary.withValues(
                              alpha: 0.1,
                            ),
                            blurRadius: 10.r,
                            offset: Offset(0, -3.w),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return context.l10n.emailRequired;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: context.l10n.emailAddressHint,
                              prefixIcon: Icon(Icons.email, size: 20.r),
                              filled: true,
                              fillColor: context.themeColors.textMuted
                                  .withValues(alpha: 0.1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            context.l10n.emailVerificationHelp,
                            style: AppTextStyles.bodyInterMedium14.copyWith(
                              color: context.themeColors.textMuted,
                            ),
                          ),
                          const SizedBox(height: 24),
                          IgnorePointer(
                            ignoring: isLoading,
                            child: GradientElevatedButton(
                              buttonText: isLoading
                                  ? context.l10n.sending
                                  : context.l10n.sendVerificationCode,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ForgotPasswordCubit>().sendOtp(
                                    email: _emailController.text.trim(),
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 24.w),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${context.l10n.rememberPassword} ',
                                style: AppTextStyles.bodyInterMedium14.copyWith(
                                  color: context.themeColors.textSecondary,
                                ),
                              ),
                              CustomTextButton(
                                onTap: () => Navigator.pop(context),
                                text: context.l10n.backToLogin,
                              ),
                            ],
                          ),
                        ],
                      ),
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
}
