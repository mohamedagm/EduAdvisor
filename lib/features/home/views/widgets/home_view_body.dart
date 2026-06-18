import 'package:edu_advisor/features/home/views/widgets/degree_progress_indicator.dart';
import 'package:edu_advisor/features/home/views/widgets/recommended_courses_builder.dart';
import 'package:edu_advisor/features/home/views/widgets/registeration_alert.dart';
import 'package:edu_advisor/features/home/views/widgets/section_header.dart';
import 'package:edu_advisor/features/home/views/widgets/welcome_card.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  final String fullName;

  const HomeViewBody({super.key, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 12,
            children: [
              WelcomeCard(fullName: fullName),

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
