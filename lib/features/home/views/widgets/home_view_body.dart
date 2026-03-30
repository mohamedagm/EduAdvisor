import 'package:edu_advisor/features/home/views/widgets/degree_progress_indicator.dart';
import 'package:edu_advisor/features/home/views/widgets/recommended_courses_builder.dart';
import 'package:edu_advisor/features/home/views/widgets/registeration_alert.dart';
import 'package:edu_advisor/features/home/views/widgets/section_header.dart';
import 'package:edu_advisor/features/home/views/widgets/welcome_card.dart';
import 'package:flutter/material.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                WelcomeCard(),

                SectionHeader(),

                RecommendedCoursesBuilder(),

                DegreeProgressIndicator(),

                RegisterationAlert(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
