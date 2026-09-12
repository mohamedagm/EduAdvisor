import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/features/services/views/widgets/course_registration_tool.dart';
import 'package:edu_advisor/features/services/views/widgets/service_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseRegistrationView extends StatelessWidget {
  const CourseRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ServiceAppBar(
        title: context.l10n.courseRegistrationTitle,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: const CourseRegistrationTool(),
      ),
    );
  }
}