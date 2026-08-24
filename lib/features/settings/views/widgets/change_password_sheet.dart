import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/user/data/models/change_password_request_model.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';
import 'package:edu_advisor/features/user/manager/change_password_cubit.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordSheet extends StatelessWidget {
  const ChangePasswordSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ChangePasswordSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(repo: getIt<UserRepo>()),
      child: const _ChangePasswordSheetBody(),
    );
  }
}

class _ChangePasswordSheetBody extends StatefulWidget {
  const _ChangePasswordSheetBody();

  @override
  State<_ChangePasswordSheetBody> createState() =>
      _ChangePasswordSheetBodyState();
}

class _ChangePasswordSheetBodyState extends State<_ChangePasswordSheetBody> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ChangePasswordCubit>().changePassword(
          ChangePasswordRequestModel(
            currentPassword: _currentController.text,
            newPassword: _newController.text,
            confirmPassword: _confirmController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
        child: Container(
          padding: EdgeInsets.fromLTRB(24.w, 12.w, 24.w, 24.w),
          decoration: BoxDecoration(
            color: context.themeColors.card,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SingleChildScrollView(
            child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  AppToast.success(
                    context,
                    title: context.l10n.passwordUpdated,
                    description: state.message,
                  );
                  Navigator.pop(context);
                }

                if (state is ChangePasswordFailure) {
                  AppToast.error(
                    context,
                    title: context.l10n.passwordResetFailed,
                    description: state.failure.message,
                  );
                }
              },
              builder: (context, state) {
                final isLoading = state is ChangePasswordLoading;

                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40.w,
                        height: 4.w,
                        margin: EdgeInsets.only(bottom: 20.w),
                        decoration: BoxDecoration(
                          color: context.themeColors.border,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.lock_reset_rounded,
                            color: context.colorScheme.primary,
                            size: 26.r,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            context.l10n.changePassword,
                            style: AppTextStyles.heading2PoppinsSb18
                                .responsive.copyWith(
                              color: context.themeColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.w),
                      _passwordField(
                        context: context,
                        controller: _currentController,
                        label: context.l10n.currentPassword,
                        hint: '••••••••',
                        obscure: _obscureCurrent,
                        toggleObscure: () => setState(
                          () => _obscureCurrent = !_obscureCurrent,
                        ),
                        enabled: !isLoading,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.passwordRequired;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.w),
                      _passwordField(
                        context: context,
                        controller: _newController,
                        label: context.l10n.newPassword,
                        hint: context.l10n.enterNewPassword,
                        obscure: _obscureNew,
                        toggleObscure: () =>
                            setState(() => _obscureNew = !_obscureNew),
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
                      ),
                      SizedBox(height: 16.w),
                      _passwordField(
                        context: context,
                        controller: _confirmController,
                        label: context.l10n.confirmNewPassword,
                        hint: context.l10n.confirmNewPassword,
                        obscure: _obscureConfirm,
                        toggleObscure: () => setState(
                          () => _obscureConfirm = !_obscureConfirm,
                        ),
                        enabled: !isLoading,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.confirmPasswordRequired;
                          }
                          if (value != _newController.text) {
                            return context.l10n.passwordsDoNotMatch;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.w),
                      GradientElevatedButton(
                        buttonText: isLoading
                            ? context.l10n.loading
                            : context.l10n.updatePasswordBtn,
                        onPressed: isLoading ? () {} : _submit,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
    );
  }

  Widget _passwordField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscure,
    required VoidCallback toggleObscure,
    required bool enabled,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      enabled: enabled,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(Icons.lock_outline, size: 20.r),
        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            size: 20.r,
            color: context.themeColors.textMuted,
          ),
          onPressed: toggleObscure,
        ),
        filled: true,
        fillColor: context.themeColors.textMuted.withValues(alpha: 0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
