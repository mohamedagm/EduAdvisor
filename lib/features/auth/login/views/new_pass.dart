import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/reset_password_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/reset_password_state.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/login/views/advisor_login.dart';
import 'package:edu_advisor/features/auth/login/views/student_login.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/custom_text_button.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class NewPasswordScreen extends StatefulWidget {
  final RegisterRole role;
  final String email;
  final String token;

  const NewPasswordScreen({
    super.key,
    required this.role,
    required this.email,
    required this.token,
  });

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          AppToast.success(
            context,
            title: context.l10n.passwordUpdated,
            description: state.message,
          );

          Future.delayed(const Duration(seconds: 1), () {
            if (!context.mounted) return;
            if (widget.role == RegisterRole.student) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => const StudentLoginScreen(
                    registerRole: RegisterRole.student,
                  ),
                ),
                (route) => false,
              );
            } else {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const AdvisorLoginScreen()),
                (route) => false,
              );
            }
          });
        }

        if (state is ResetPasswordFailure) {
          AppToast.error(
            context,
            title: context.l10n.passwordResetFailed,
            description: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;

        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  GradiantContainer(
                    mainText: context.l10n.newPassword,
                    optionalText: context.l10n.strongPasswordHelp,
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      top: height * 0.41,
                      right: width * 0.03,
                      left: width * 0.03,
                    ),
                    constraints: BoxConstraints(minHeight: height * 0.35),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: context.themeColors.card,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: context.themeColors.textPrimary.withValues(
                            alpha: 0.1,
                          ),
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          enabled: !isLoading,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.l10n.enterNewPassword;
                            }
                            if (value.length < 6) {
                              return context.l10n.passwordSixCharacters;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: context.l10n.newPassword,
                            hintText: context.l10n.enterNewPassword,
                            prefixIcon: const Icon(Icons.lock),
                            filled: true,
                            fillColor: context.themeColors.textMuted.withValues(
                              alpha: 0.1,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          enabled: !isLoading,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.l10n.confirmPasswordRequired;
                            }
                            if (value != _passwordController.text) {
                              return context.l10n.passwordsDoNotMatch;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: context.l10n.confirmPassword,
                            hintText: context.l10n.confirmNewPassword,
                            prefixIcon: const Icon(Icons.lock_reset),
                            filled: true,
                            fillColor: context.themeColors.textMuted.withValues(
                              alpha: 0.1,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        GradientElevatedButton(
                          buttonText: isLoading
                              ? context.l10n.loading
                              : context.l10n.resetPassword,
                          onPressed: isLoading
                              ? () {}
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<ResetPasswordCubit>()
                                        .resetPassword(
                                          email: widget.email,
                                          token: widget.token,
                                          newPassword: _passwordController.text,
                                          confirmPassword:
                                              _confirmPasswordController.text,
                                        );
                                  }
                                },
                        ),

                        const SizedBox(height: 24),

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
    );
  }
}
