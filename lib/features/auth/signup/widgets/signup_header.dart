import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:50),
      height: 120,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
           
            AppColors.bluePrimary,
            AppColors.purplePrimary,
        
          ],
        ),
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(30),
        //   bottomRight: Radius.circular(30),
        // ),
      ),
      alignment: Alignment.center,
      child: const Text(
        "Create Account",
        style: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}