import 'package:edu_advisor/features/auth/signup/widgets/custom_text_field.dart';
import 'package:edu_advisor/features/auth/signup/widgets/signup_filed_label.dart';
import 'package:edu_advisor/features/auth/signup/widgets/signup_header.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:edu_advisor/valdations/valditors.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();


  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final idController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isObscure = true;

  @override
  void dispose() {
   
    nameController.dispose();
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

    return Scaffold(
      body: Column(
        children: [
          const SignupHeader(), 
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: screenHeight * 0.01, bottom: 20),
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
                          /// Name
                          _buildField(label: 'Name', hint: "Enter your name", icon: Icons.person, controller: nameController, validator: Validators.name),
                          const SizedBox(height: 12),

                          /// Email
                          _buildField(label: 'Email', hint: "Email", icon: Icons.email, controller: emailController, validator: Validators.email),
                          const SizedBox(height: 12),

                          /// Phone
                          _buildField(label: 'Phone', hint: "+02115798392", icon: Icons.phone, controller: phoneController, validator: Validators.password),
                          const SizedBox(height: 12),

                          /// National Id
                          _buildField(label: 'National Id', hint: "Enter your national id", icon: Icons.book, controller: idController, validator: Validators.password),
                          const SizedBox(height: 12),

                          /// Password
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel(text: 'Password'),
                              CustomTextField(
                                hint: "Password",
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
                          ),
                          const SizedBox(height: 12),

                          /// Confirm Password
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const FieldLabel(text: 'Confirm Password'),
                              CustomTextField(
                                hint: "Confirm Password",
                                icon: Icons.lock,
                                controller: confirmPasswordController,
                                obscureText: isObscure,
                                validator: (value) => Validators.confirmPassword(value, passwordController.text),
                                suffixIcon: IconButton(
                                  icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                                  onPressed: () => setState(() => isObscure = !isObscure),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          /// Button
                          SizedBox(
                            width: double.infinity,
                            child: GradientElevatedButton(
                              buttonText: "Sign Up",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // حالياً UI فقط، مفيش Bloc
                                  debugPrint("Form is Valid! Waiting for Backend...");
                                }
                              },
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
  }

  Widget _buildField({required String label, required String hint, required IconData icon, required TextEditingController controller, String? Function(String?)? validator}) {
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
}