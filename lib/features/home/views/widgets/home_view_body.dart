import 'package:edu_advisor/features/home/views/widgets/degree_progress_indicator.dart';
import 'package:edu_advisor/features/home/views/widgets/recommended_courses_builder.dart';
import 'package:edu_advisor/features/home/views/widgets/registeration_alert.dart';
import 'package:edu_advisor/features/home/views/widgets/section_header.dart';
import 'package:edu_advisor/features/home/views/widgets/welcome_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12.w,
            children: const [
              WelcomeCard(),
              SectionHeader(),
              RecommendedCoursesBuilder(),
              DegreeProgressIndicator(),
              RegisterationAlert(),
            ],
          ),
        ),
      ),
    );
  }
}
