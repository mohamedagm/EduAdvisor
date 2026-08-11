import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomTextButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: AppTextStyles.interRegular16.copyWith(
          fontSize: 16.sp,
          color: context.themeColors.info,
        ),
      ),
    );
  }
}
