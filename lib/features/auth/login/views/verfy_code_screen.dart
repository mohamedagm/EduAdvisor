import 'dart:async';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VerifyCodeScreen extends StatefulWidget {
 
  const VerifyCodeScreen({super.key, });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final int otpLength = 6;
  final _formKey = GlobalKey<FormState>();

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  bool isVerified = false;
  bool isVerifying = false;
  bool isResending = false;

  int resendCountdown = 0;
  Timer? _timer;

  String statusMessage = 'Enter the code sent to your email';
  StatusType statusType = StatusType.info;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
    Future.delayed(const Duration(milliseconds: 200), () {
      focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  String get otpCode => controllers.map((c) => c.text).join();

  void onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < otpLength - 1) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  void startResendCountdown() {
    setState(() {
      isResending = true;
      resendCountdown = 30;
      statusMessage = 'Code sent! Enter the code below.';
      statusType = StatusType.success;
      for (var c in controllers) {
        c.clear();
      }
    });
    _formKey.currentState?.reset();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        resendCountdown--;
        if (resendCountdown <= 0) {
          isResending = false;
          timer.cancel();
        }
      });
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      focusNodes[0].requestFocus();
    });
  }

  Future<void> verifyCode() async {
    // Validate all TextFormFields via the Form key
    if (!_formKey.currentState!.validate()) {
      setState(() {
        statusMessage = 'Please fill in all 6 digits.';
        statusType = StatusType.error;
      });
      return;
    }

    setState(() {
      isVerifying = true;
      statusMessage = 'Verifying...';
      statusType = StatusType.info;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isVerifying = false;
      isVerified = true;
      statusMessage = 'Code verified successfully!';
      statusType = StatusType.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final height = size.height;
    // final width = size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
       
          GradiantContainer(
            mainText: "Verify Code",
            optionalText: "Don't worry! we'll help you reset it.",
          ),
         
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              // ── Form wraps all TextFormFields ──────────────────────
              child: Container(
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

                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Enter 6-Digit Code',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 20),

                      // ── OTP row of TextFormFields ──────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(otpLength, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 44,
                            height: 56,
                            child: TextFormField(
                              controller: controllers[index],
                              focusNode: focusNodes[index],
                              enabled: !isVerified,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                contentPadding: EdgeInsets.zero,
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF7B5EA7),
                                    width: 2,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE24B4A),
                                    width: 1.5,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xFFE24B4A),
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                                // suppress per-field error text (shown in statusMessage instead)
                                errorStyle: const TextStyle(height: 0),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              // validator called by _formKey.currentState!.validate()
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return ''; // triggers red border, no inline text
                                }
                                return null;
                              },
                              onChanged: (value) => onOtpChanged(index, value),
                            ),
                          );
                        }),
                      ),

                      const SizedBox(height: 16),

                      // ── Status message ─────────────────────────────
                      Text(
                        statusMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: statusType == StatusType.error
                              ? const Color(0xFFE24B4A)
                              : statusType == StatusType.success
                              ? const Color(0xFF1D9E75)
                              : const Color(0xFF7B5EA7),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ── Resend link ────────────────────────────────
                      GestureDetector(
                        onTap: (!isResending && !isVerified)
                            ? startResendCountdown
                            : null,
                        child: Text(
                          isResending
                              ? 'Resend in ${resendCountdown}s'
                              : 'Resend Verification Code',
                          style: TextStyle(
                            fontSize: 13,
                            color: isResending
                                ? Colors.grey
                                : const Color(0xFF7B5EA7),
                            decoration: (!isResending && !isVerified)
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      Container(
                        width: double.infinity,
                        height: 56,
                        margin: const EdgeInsets.symmetric(horizontal: 32),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.bluePrimary,
                              AppColors.purplePrimary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(
                            25,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: (isVerifying || isVerified)
                              ? null
                              : verifyCode,
                          child: isVerifying
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  isVerified ? 'Verified ✓' : 'Verify Code',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum StatusType { error, success, info }


////////Note:
///in this screen need to handle tex field validation and error handling
///also need to handle resend code and verify code logic with API integration
///need to handle text bassed status messages for user feedback (e.g. "Code sent!", "Invalid code", "Code verified", etc.)