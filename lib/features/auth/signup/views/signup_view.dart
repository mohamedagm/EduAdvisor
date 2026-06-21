import 'dart:io';
import 'package:dio/dio.dart';
import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/departments_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/departments_state.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/data/models/register_student_request_model.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/verify_code_repo.dart';
import 'package:edu_advisor/features/auth/login/views/student_profile.dart';
import 'package:edu_advisor/features/auth/login/views/verfy_code_screen.dart';
import 'package:edu_advisor/features/auth/signup/widgets/custom_text_field.dart';
import 'package:edu_advisor/features/auth/signup/widgets/department_dropdown.dart';
import 'package:edu_advisor/features/auth/signup/widgets/signup_filed_label.dart';
import 'package:edu_advisor/features/auth/signup/widgets/signup_header.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:edu_advisor/valdations/valditors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.registerRole});

  final RegisterRole registerRole;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  File? studentProfileImage;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final studentCodeController = TextEditingController();
  final idController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? selectedDepartmentId;
  bool isObscure = true;

  bool get isStudent => widget.registerRole == RegisterRole.student;

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    studentCodeController.dispose();
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

        return BlocBuilder<DepartmentsCubit, DepartmentsState>(
          builder: (context, deptState) {
            if (deptState is DepartmentsLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (deptState is DepartmentsFailure) {
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.l10n.failedToLoadDepartments,
                        style: TextStyle(color: context.colorScheme.error),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () =>
                            context.read<DepartmentsCubit>().fetchDepartments(),
                        child: Text(context.l10n.retry),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Scaffold(
              body: Column(
                children: [
                  const SignupHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        bottom: 20,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: context.themeColors.card,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ImagePickerWidget(
                                    onImageSelected: (image) {
                                      setState(() {
                                        studentProfileImage = image;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  _buildField(
                                    label: context.l10n.firstName,
                                    hint: context.l10n.enterFirstName,
                                    icon: Icons.person,
                                    controller: nameController,
                                    validator: (value) =>
                                        Validators.name(value, context.l10n),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildField(
                                    label: context.l10n.lastName,
                                    hint: context.l10n.enterLastName,
                                    icon: Icons.person,
                                    controller: lastNameController,
                                    validator: (value) =>
                                        Validators.name(value, context.l10n),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildField(
                                    label: context.l10n.email,
                                    hint: context.l10n.email,
                                    icon: Icons.email,
                                    controller: emailController,
                                    validator: (value) =>
                                        Validators.email(value, context.l10n),
                                  ),
                                  const SizedBox(height: 12),
                                  _buildField(
                                    label: context.l10n.studentCode,
                                    hint: '2023-123',
                                    icon: Icons.code,
                                    controller: studentCodeController,
                                  ),
                                  const SizedBox(height: 12),
                                  DepartmentDropdown(
                                    value: selectedDepartmentId,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedDepartmentId = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 12),
                                  _buildField(
                                    label: context.l10n.nationalId,
                                    hint: context.l10n.enterNationalId,
                                    icon: Icons.badge,
                                    controller: idController,
                                  ),
                                  const SizedBox(height: 12),
                                  _buildPasswordField(),
                                  const SizedBox(height: 12),
                                  _buildConfirmPasswordField(),
                                  const SizedBox(height: 20),
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
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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

  void _onSignUpPressed(BuildContext context, {required bool isLoading}) async {
    if (isLoading || !_formKey.currentState!.validate()) return;

    MultipartFile? profileImageFile;

    if (studentProfileImage != null) {
      profileImageFile = await MultipartFile.fromFile(
        studentProfileImage!.path,
        filename: studentProfileImage!.path.split('/').last,
      );
    }

    if (!context.mounted) return;

    context.read<AuthCubit>().registerStudent(
      RegisterStudentRequestModel(
        firstName: nameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        studentCode: studentCodeController.text.trim(),
        departmentId: selectedDepartmentId ?? '',
        nationalId: idController.text.trim(),
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
        profileImage: profileImageFile,
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
