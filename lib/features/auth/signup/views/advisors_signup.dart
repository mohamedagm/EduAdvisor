import 'dart:io';

import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/departments_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/departments_state.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/data/models/register_advisor_request_model.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
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
import 'package:image_picker/image_picker.dart';

class AdvisorSignupScreen extends StatefulWidget {
  const AdvisorSignupScreen({super.key, required this.registerRole});

  final RegisterRole registerRole;

  @override
  State<AdvisorSignupScreen> createState() => _AdvisorSignupScreenState();
}

class _AdvisorSignupScreenState extends State<AdvisorSignupScreen> {
  File? advisorProfileImage;
  // File? _selectedImage;
  // final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final idController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? selectedDepartmentId;
  bool isObscure = true;

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    idController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // bool _isPickingImage = false;

  // Future<void> _pickImage() async {
  //   if (_isPickingImage) return;

  //   _isPickingImage = true;

  //   try {
  //     final XFile? picked = await _picker.pickImage(
  //       source: ImageSource.gallery,
  //       imageQuality: 80,
  //     );

  //     if (picked != null && mounted) {
  //       setState(() {
  //         _selectedImage = File(picked.path);
  //       });
  //     }
  //   } finally {
  //     _isPickingImage = false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) =>
          AuthCubit(authRepo: AuthRepo(apiConsumer: DioConsumer())),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: _authListener,
        builder: (context, state) {
          final isLoading =
              state is RegisterStudentLoading ||
              state is RegisterAdvisorLoading;

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
                          'Failed to load departments',
                          style: TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () => context
                              .read<DepartmentsCubit>()
                              .fetchDepartments(),
                          child: const Text('Retry'),
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
                              margin: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                                        advisorProfileImage = image;
                                      },
                                    ),
                                    _buildField(
                                      label: 'First Name',
                                      hint: 'Enter your first name',
                                      icon: Icons.person,
                                      controller: nameController,
                                      validator: Validators.name,
                                    ),
                                    const SizedBox(height: 12),
                                    _buildField(
                                      label: 'Last Name',
                                      hint: 'Enter your last name',
                                      icon: Icons.person,
                                      controller: lastNameController,
                                      validator: Validators.name,
                                    ),
                                    const SizedBox(height: 12),
                                    _buildField(
                                      label: 'Email',
                                      hint: 'Email',
                                      icon: Icons.email,
                                      controller: emailController,
                                      validator: Validators.email,
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
                                      label: 'Phone',
                                      hint: '+02115798392',
                                      icon: Icons.phone,
                                      controller: phoneController,
                                    ),
                                    const SizedBox(height: 12),
                                    _buildField(
                                      label: 'National Id',
                                      hint: 'Enter your national id',
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
                                                ? 'Signing Up...'
                                                : 'Sign Up',
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
      ),
    );
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state is RegisterStudentSuccess || state is RegisterAdvisorSuccess) {
      final message = state is RegisterStudentSuccess
          ? state.response.message
          : (state as RegisterAdvisorSuccess).response.message;

      AppToast.success(
        context,
        title: 'Registration Successful',
        description: message,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => VerifyCodeCubit(
              verifyCodeRepo: VerifyCodeRepo(apiConsumer: DioConsumer()),
            ),
            child: VerifyCodeScreen(
              email: emailController.text.trim(),
              role: widget.registerRole,
            ),
          ),
        ),
      );
    }

    if (state is RegisterStudentFailure || state is RegisterAdvisorFailure) {
      final message = state is RegisterStudentFailure
          ? state.failure.message
          : (state as RegisterAdvisorFailure).failure.message;

      AppToast.error(
        context,
        title: 'Registration Failed',
        description: message,
      );
    }
  }

  void _onSignUpPressed(BuildContext context, {required bool isLoading}) {
    if (isLoading || !_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().registerAdvisor(
      RegisterAdvisorRequestModel(
        firstName: nameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
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
        const FieldLabel(text: 'Password'),
        CustomTextField(
          hint: 'Password',
          icon: Icons.lock,
          controller: passwordController,
          validator: Validators.password,
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
        const FieldLabel(text: 'Confirm Password'),
        CustomTextField(
          hint: 'Confirm Password',
          icon: Icons.lock,
          controller: confirmPasswordController,
          obscureText: isObscure,
          validator: (value) =>
              Validators.confirmPassword(value, passwordController.text),
          suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => isObscure = !isObscure),
          ),
        ),
      ],
    );
  }
}
