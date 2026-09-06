import 'package:edu_advisor/core/api/api_constants.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseTreeCard extends StatelessWidget {
  const CourseTreeCard({super.key});

  Future<void> _openCourseMap(BuildContext context) async {
    final uri = Uri.parse(ApiConstants.courseTreeUrl);
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      AppToast.error(
        context,
        title: context.l10n.courseTreeLaunchErrorTitle,
        description: context.l10n.courseTreeLaunchErrorMessage,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.themeColors.purpleContainer,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => _openCourseMap(context),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48.r,
                width: 48.r,
                decoration: BoxDecoration(
                  gradient: AppGradients.primary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.account_tree_outlined,
                  color: Colors.white,
                  size: 26.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            context.l10n.courseTreeTitle,
                            style: AppTextStyles.heading3PoppinsReg16.copyWith(
                              fontSize: 16.sp,
                              color: context.themeColors.textPrimary,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14.r,
                          color: context.themeColors.textMuted,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      context.l10n.courseTreeMessage,
                      style: AppTextStyles.poppinsRegular14.copyWith(
                        fontSize: 14.sp,
                        color: context.themeColors.textSecondary,
                      ),
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