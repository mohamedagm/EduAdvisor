import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
bool isObscure = true;
  @override
  Widget build(BuildContext context) {

    return Form(
      key: formKey,
      child: Column(
        children: [

          /// Email
          Column( 
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Email' , style: AppTextStyles.bodyInterMedium18.copyWith(color: AppColors.gray900)),
              TextFormField(
                controller: emailController,
              
                      
                decoration: InputDecoration(
                      
                  prefixIcon: Icon(Icons.email),
              filled: true,
                      fillColor: AppColors.gray100,
              contentPadding:EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              
                      border: OutlineInputBorder(
                      
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
                      ),
                  hintText: "email@university.edu",
                    enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
              
                      ),
                       focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                 color: AppColors.gray300,
                width: 1.5,///
              ),
                      ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!value.contains("@")) {
                    return "Enter valid email";
                  }
                  return null;
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Password
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text('Password' , style: AppTextStyles.bodyInterMedium18.copyWith(color: AppColors.gray900)),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  
                  prefixIcon: Icon(Icons.lock_outline),
              
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
              isObscure = !isObscure;
                      });
                    },
                  ),
                  
                      filled: true,
                      fillColor: AppColors.gray100,
                  hintText: "Password",
                  contentPadding:EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              
                      border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
                      ),
                
                    enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
              
                      ),
                       focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.gray300,
                width: 1.5,
              ),
                      ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Password is required";
                  }
                  if (value.length < 6) {
                    return "Password must be 6 characters";
                  }
                  return null;
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Button
         
        ],
      ),
    );
  }
}