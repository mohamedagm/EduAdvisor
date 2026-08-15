import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/data/models/register_advisor_request_model.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/verify_code_repo.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/departments_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/presentation/views/login/verfy_code_screen.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/custom_text_field.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/department_dropdown.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/faculty_dropdown.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/signup_filed_label.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/signup_header.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:edu_advisor/valdations/valditors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvisorSignupScreen extends StatefulWidget {
  const AdvisorSignupScreen({super.key, required this.registerRole});

  final RegisterRole registerRole;

  @override
  State<AdvisorSignupScreen> createState() => _AdvisorSignupScreenState();
}

class _AdvisorSignupScreenState extends State<AdvisorSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameARController = TextEditingController();
  final nameENController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final idController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? selectedFacultyId;
  String? selectedDepartmentId;
  bool isObscure = true;

  @override
  void dispose() {
    nameARController.dispose();
    nameENController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    idController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: _authListener,
      builder: (context, state) {
        final isLoading =
            state is RegisterStudentLoading || state is RegisterAdvisorLoading;

        return Scaffold(
          body: Column(
            children: [
              const SignupHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.01,
                    bottom: 20.w,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 24.w),
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: context.themeColors.card,
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(blurRadius: 10.r, color: Colors.black12),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildField(
                                label: context.l10n.fullNameArabic,
                                hint: context.l10n.enterFullName,
                                icon: Icons.person,
                                controller: nameARController,
                                validator: (value) =>
                                    Validators.name(value, context.l10n),
                              ),
                              const SizedBox(height: 12),
                              _buildField(
                                label: context.l10n.fullNameEnglish,
                                hint: context.l10n.enterFullName,
                                icon: Icons.person,
                                controller: nameENController,
                                validator: (value) =>
                                    Validators.name(value, context.l10n),
                              ),
                              const SizedBox(height: 12),
                              _buildField(
                                label: context.l10n.email,
                                hint: context.l10n.emailPlaceholder,
                                icon: Icons.email,
                                controller: emailController,
                                validator: (value) =>
                                    Validators.email(value, context.l10n),
                              ),
                              const SizedBox(height: 12),
                              FacultyDropdown(
                                value: selectedFacultyId,
                                onChanged: _onFacultyChanged,
                              ),
                              const SizedBox(height: 12),
                              DepartmentDropdown(
                                key: ValueKey(selectedFacultyId),
                                value: selectedDepartmentId,
                                facultyId: selectedFacultyId,
                                onChanged: (value) {
                                  setState(() {
                                    selectedDepartmentId = value;
                                  });
                                },
                              ),
                              const SizedBox(height: 12),
                              _buildField(
                                label: context.l10n.phone,
                                hint: '+02115798392',
                                icon: Icons.phone,
                                controller: phoneController,
                              ),
                              const SizedBox(height: 12),
                              _buildField(
                                label: context.l10n.nationalId,
                                hint: context.l10n.enterNationalId,
                                icon: Icons.menu_book,
                                controller: idController,
                              ),
                              const SizedBox(height: 12),
                              _buildPasswordField(),
                              const SizedBox(height: 12),
                              _buildConfirmPasswordField(),
                              SizedBox(height: 20.w),
                              IgnorePointer(
                                ignoring: isLoading,
                                child: Opacity(
                                  opacity: isLoading ? 0.75 : 1,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: GradientElevatedButton(
                                      buttonText: isLoading
                                          ? context.l10n.signingUp
                                          : context.l10n.signUp,
                                      onPressed: () => _onSignUpPressed(
                                        context,
                                        isLoading: isLoading,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.w),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${context.l10n.alreadyHaveAccount} '),
                          GestureDetector(
                            onTap: () => Navigator.of(context).maybePop(),
                            child: Text(
                              context.l10n.login,
                              style: TextStyle(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.w),
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

  void _onFacultyChanged(String? facultyId) {
    setState(() {
      selectedFacultyId = facultyId;
      selectedDepartmentId = null;
    });

    if (facultyId != null) {
      context.read<DepartmentsCubit>().fetchDepartments(facultyId: facultyId);
    }
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is RegisterStudentSuccess || state is RegisterAdvisorSuccess) {
      final message = state is RegisterStudentSuccess
          ? state.response.message
          : (state as RegisterAdvisorSuccess).response.message;

      AppToast.success(
        context,
        title: context.l10n.registrationSuccessful,
        description: message,
      );

      Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) =>
                    VerifyCodeCubit(verifyCodeRepo: getIt<VerifyCodeRepo>()),
                child: VerifyCodeScreen(
                  email: emailController.text.trim(),
                  role: widget.registerRole,
                ),
              ),
            ),
          );
        }
      });
    }

    if (state is RegisterStudentFailure || state is RegisterAdvisorFailure) {
      final message = state is RegisterStudentFailure
          ? state.failure.message
          : (state as RegisterAdvisorFailure).failure.message;

      AppToast.error(
        context,
        title: context.l10n.registrationFailed,
        description: message,
      );
    }
  }

  void _onSignUpPressed(BuildContext context, {required bool isLoading}) {
    if (isLoading || !_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().registerAdvisor(
      RegisterAdvisorRequestModel(
        fullNameAR: nameARController.text.trim(),
        fullNameEN: nameENController.text.trim(),
        email: emailController.text.trim(),
        facultyId: selectedFacultyId ?? '',
        departmentId: selectedDepartmentId ?? '',
        nationalId: idController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
    );
  }

  Widget _buildField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(text: label),
        CustomTextField(
          hint: hint,
          icon: icon,
          controller: controller,
          validator: validator,
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(text: context.l10n.password),
        CustomTextField(
          hint: context.l10n.password,
          icon: Icons.lock,
          controller: passwordController,
          validator: (value) => Validators.password(value, context.l10n),
          obscureText: isObscure,
          suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => isObscure = !isObscure),
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(text: context.l10n.confirmPassword),
        CustomTextField(
          hint: context.l10n.confirmPassword,
          icon: Icons.lock,
          controller: confirmPasswordController,
          obscureText: isObscure,
          validator: (value) => Validators.confirmPassword(
            value,
            passwordController.text,
            context.l10n,
          ),
          suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => isObscure = !isObscure),
          ),
        ),
      ],
    );
  }
}
