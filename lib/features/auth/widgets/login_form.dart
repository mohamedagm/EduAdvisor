import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.email,
                style: AppTextStyles.bodyInterMedium18.copyWith(
                  fontSize: 18.sp,
                  color: context.themeColors.textPrimary,
                ),
              ),
              TextFormField(
                controller: widget.emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email, size: 20.r),
                  filled: true,
                  fillColor: context.themeColors.mutedSurface,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.w,
                    horizontal: 16.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  hintText: context.l10n.emailHint,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: context.colorScheme.outline,
                      width: 1.5.w,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.emailRequired;
                  }
                  if (!value.contains('@')) {
                    return context.l10n.validEmailRequired;
                  }
                  return null;
                },
              ),
            ],
          ),
          SizedBox(height: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.password,
                style: AppTextStyles.bodyInterMedium18.copyWith(
                  fontSize: 18.sp,
                  color: context.themeColors.textPrimary,
                ),
              ),
              TextFormField(
                controller: widget.passwordController,
                obscureText: isObscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline, size: 20.r),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                      size: 20.r,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: context.themeColors.mutedSurface,
                  hintText: context.l10n.password,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 16.w,
                    horizontal: 16.w,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: context.colorScheme.outline,
                      width: 1.5.w,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.passwordRequired;
                  }
                  if (value.length < 6) {
                    return context.l10n.passwordSixCharacters;
                  }
                  return null;
                },
              ),
            ],
          ),
          SizedBox(height: 16.w),
        ],
      ),
    );
  }
}
