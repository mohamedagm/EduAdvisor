import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/auth/Manager/cubit/verify_code_cubit.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/data/repo/verify_code_repo.dart';
import 'package:edu_advisor/features/auth/login/views/verfy_code_screen.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/custom_text_button.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ── 🎯 حوّلنا الشاشة لـ StatefulWidget علشان نعرف نستخدم الـ Controller ونقفل الـ Memory leak ──
class ForgotPasswordScreen extends StatefulWidget {
  final RegisterRole registerRole;
 
  const ForgotPasswordScreen({super.key, required this.registerRole});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // 1️⃣ تعريف الـ Controller والـ Form Key
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose(); // تنظيف الـ Memory
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // ربط الـ Form
          child: Stack(
            children: [
              const GradiantContainer(
                mainText: "Forgot Password?",
                optionalText: "Don't worry! we'll help you reset it.",
              ),

              /// Card Section
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.41,
                  right: width * 0.03,
                  left: width * 0.03,
                ),
                constraints: BoxConstraints(
                  minHeight: height * 0.35,
                ),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Email field
                    TextFormField(
                      controller: _emailController, // 2️⃣ ربط الكنترولر هنا بسلام
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "your.email@university.edu.eg",
                        prefixIcon: const Icon(Icons.email),
                        filled: true,
                        fillColor: AppColors.gray400.withValues(alpha: 0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "We'll send a 6-digit verification code to this email",
                      style: AppTextStyles.bodyInterMedium14.copyWith(
                        color: AppColors.gray400,
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Button
                    GradientElevatedButton(
                      buttonText: 'Send Verification code',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // 💡 ملحوظة: الصح هنا إنك تكلمي الـ Cubit يبعت الـ OTP الأول.
                          // الكود ده معمول بحيث ينقلك مباشرة وجاهز لاستقبال التعديل الجاي في الـ VerifyCodeScreen.
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
                                  email: _emailController.text.trim(),
                                  role: widget.registerRole,
                                  isFromForgotPassword: true, // 3️⃣ الـ Flag اللي هيحل أزمة التوجيه!
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 24),

                    /// Back to login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Remember your password? ",
                          style: AppTextStyles.bodyInterMedium14.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        CustomTextButton(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          text: 'Back to Login',
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
  }
}