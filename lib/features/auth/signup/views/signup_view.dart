
import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_cubit.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/auth_state.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/data/models/register_student_request_model.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/auth_repo.dart';
import 'package:edu_advisor/features/auth/data/repo/verify_code_repo.dart';
import 'package:edu_advisor/features/auth/login/views/verfy_code_screen.dart';

import 'package:edu_advisor/features/auth/signup/widgets/custom_text_field.dart';
import 'package:edu_advisor/features/auth/signup/widgets/department_dropdown.dart';
import 'package:edu_advisor/features/auth/signup/widgets/signup_filed_label.dart';
import 'package:edu_advisor/features/auth/signup/widgets/signup_header.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:edu_advisor/valdations/valditors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// enum RegisterRole { student, advisor }

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.registerRole});

  final RegisterRole registerRole;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final studentCodeController = TextEditingController();
  final idController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final departmentController = TextEditingController();
  String? selectedDepartmentId;

  bool isObscure = true;

  bool get isStudent => widget.registerRole == RegisterRole.student;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    studentCodeController.dispose();
    idController.dispose();
    confirmPasswordController.dispose();
    lastNameController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: _authListener,
      builder: (context, state) {
        final isLoading =
            state is RegisterStudentLoading ||
            state is RegisterAdvisorLoading;
    
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
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(blurRadius: 10, color: Colors.black12),
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildField(
                                      label: 'FirstName',
                                      hint: 'Enter your first name',
                                      icon: Icons.person,
                                      controller: nameController,
                                      validator: Validators.name,
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildField(
                                      label: 'LastName',
                                      hint: 'Enter your last name',
                                      icon: Icons.person,
                                      controller: lastNameController,
                                      validator: Validators.name,
                                    ),
                                  ),
                                ],
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
                              _buildField(
                                label: 'Student Code',
                                hint: '2023-123',
                                icon: Icons.code,
                                controller: studentCodeController,
                              ),
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
Future.delayed(const Duration(milliseconds: 500), () {
        if (context.mounted) {
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
        title: 'Registration Failed',
        description: message,
      );
    }
  }

  void _onSignUpPressed(BuildContext context, {required bool isLoading}) {
    if (isLoading || !_formKey.currentState!.validate()) {
      return;
    }

    // final nameParts = _splitFullName(nameController.text.trim());

    if (isStudent) {
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
        ),
      );
      return;
    }

    // context.read<AuthCubit>().registerAdvisor(
    //   RegisterAdvisorRequestModel(
    //     firstName: nameParts.firstName,
    //     lastName: nameParts.lastName,
    //     email: emailController.text.trim(),
    //     departmentId: departmentController.text.trim(),
    //     nationalId: idController.text.trim(),
    //     studentCode: studentCodeController.text.trim(),
    //     password: passwordController.text,
    //     confirmPassword: confirmPasswordController.text,
    //   ),
    // );
  }

  // ({String firstName, String lastName}) _splitFullName(String fullName) {
  //   final parts = fullName.split(RegExp(r'\s+'));
  //   final firstName = parts.isEmpty ? '' : parts.first;
  //   final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

  //   return (firstName: firstName, lastName: lastName);
  // }

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
