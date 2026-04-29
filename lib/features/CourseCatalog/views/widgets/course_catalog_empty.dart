import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class CourseCatalogEmpty extends StatelessWidget {
  const CourseCatalogEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        Icon(Icons.menu_book, size: 50),
        Text('No courses found', style: AppTextStyles.interRegular16),
      ],
    );
  }
}
