import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCatalogEmpty extends StatelessWidget {
  const CourseCatalogEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 15.w,
      children: [
        Icon(Icons.menu_book, size: 50.r),
        Text(
          context.l10n.courseCatalogEmptyMessage,
          textAlign: TextAlign.center,
          style: AppTextStyles.interRegular16.responsive,
        ),
      ],
    );
  }
}
