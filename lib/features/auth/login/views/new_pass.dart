import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/auth/data/register_role.dart';
import 'package:edu_advisor/features/auth/login/views/advisor_login.dart';
import 'package:edu_advisor/features/auth/login/views/student_login.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/custom_text_button.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';

// ── 🎯 حوّلناها لـ StatefulWidget علشان نعرف نمسك الباسورد اللي بيتكتب ونعمل validation ──
class NewPasswordScreen extends StatefulWidget {
  final RegisterRole role;
  final String email; // 👈 زودنا استقبال الإيميل عشان الـ API
  final String token; // 👈 زودنا استقبال الـ OTP token عشان الـ API

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
  // 1️⃣ تعريف الـ Controllers والـ Form Key
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey, // ربط الـ Form لضمان إدخال البيانات صح
          child: Stack(
            children: [
              const GradiantContainer(
                mainText: "New Password", // شيلنا الـ "?" لأن خلاص بنعمل باسورد جديد
                optionalText: "Create a strong password for your account",
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
                    /// New Password field
                    TextFormField(
                      controller: _passwordController, // 2️⃣ ربط الكنترولر للباسورد
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "New Password",
                        hintText: "Enter your new password",
                        prefixIcon: const Icon(Icons.lock), // تعديل الأيقونة لقفل بديل الإيميل
                        filled: true,
                        fillColor: AppColors.gray400.withValues(alpha: 0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Confirm Password field
                    TextFormField(
                      controller: _confirmPasswordController, // 3️⃣ ربط الكنترولر لتأكيد الباسورد
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Confirm new password",
                        prefixIcon: const Icon(Icons.lock_reset),
                        filled: true,
                        fillColor: AppColors.gray400.withValues(alpha: 0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Button
                    GradientElevatedButton(
                      buttonText: 'Reset Password',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // 💡 هنا هتعملي تريجر للـ Reset Password Cubit وتباصي المتغيرات دي:
                          // widget.email 👈 الإيميل اللي جاي من شاشات ورا
                          // widget.token 👈 كود الـ OTP اللي تم التحقق منه
                          // _passwordController.text 👈 الباسورد الجديد
                          // _confirmPasswordController.text 👈 تأكيد الباسورد
                          
                          // الكود الحالي بيعمل التوجيه اللي إنتِ كاتباه بعد نجاح الـ API:
                          if (widget.role == RegisterRole.student) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StudentLoginScreen(
                                  registerRole: RegisterRole.student,
                                ),
                              ),
                              (route) => false,
                            );
                          } else {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdvisorLoginScreen(),
                              ),
                              (route) => false,
                            );
                          }
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