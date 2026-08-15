import 'dart:io';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/auth/presentation/views/widgets/skip_botton.dart';
import 'package:edu_advisor/features/widgets/auth_header.dart';
import 'package:edu_advisor/features/widgets/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class AdvisorProfile extends StatefulWidget {
  const AdvisorProfile({super.key});

  @override
  State<AdvisorProfile> createState() => _AdvisorProfileState();
}

class _AdvisorProfileState extends State<AdvisorProfile> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GradiantContainer(
            mainText: context.l10n.completeYourProfile,
            optionalText: context.l10n.addProfilePhoto,
          ),

          Align(
            alignment: Alignment(0, 0.5),
            child: Container(
              padding: EdgeInsets.all(20.w),
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                color: context.themeColors.card,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(blurRadius: 10.r, color: context.themeColors.shadow),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundColor: context.themeColors.border,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : null,
                        child: _image == null
                            ? Icon(
                                Icons.person,
                                size: 60.r,
                                color: context.themeColors.textMuted,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: pickImage,
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2.w),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: AppColors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.w),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: context.themeColors.infoContainer,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.help_outline,
                              color: context.themeColors.info,
                              size: 20,
                            ),
                            SizedBox(width: 16.w),
                            Text(
                              context.l10n.whyAddPhoto,
                              style: AppTextStyles.interRegular16.copyWith(
                                color: context.themeColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.w),
                        Text(
                          context.l10n.photoExplanation,
                          style: AppTextStyles.bodyInterMedium14.copyWith(
                            color: context.themeColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  GradientElevatedButton(
                    onPressed: () {
                      context.go(AppRoutes.advisorMain);
                    },
                    buttonText: context.l10n.continueAction,
                  ),
                  SizedBox(height: 32.w),
                  // Skip Button
                  SkipButton(
                    onTap: () {
                      context.go(AppRoutes.advisorMain);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //////////////////////////
  void pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
}
