
import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/analytics/widgets/courses_card.dart';
import 'package:edu_advisor/features/analytics/widgets/performance_card.dart';
import 'package:edu_advisor/features/widgets/advisor_header.dart';
import 'package:flutter/material.dart';

class AdvisorAnalytics extends StatefulWidget {
  const AdvisorAnalytics({super.key});

  @override
  State<AdvisorAnalytics> createState() => _AdvisorAnalyticsState();
}

class _AdvisorAnalyticsState extends State<AdvisorAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SafeArea(child: 
      Column(
        children: [
          AdvisorHeader(),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Analytics & Reports',
                    style: AppTextStyles. heading3PoppinsReg16.copyWith(color: AppColors.gray800),
                    
                ) ,
                const SizedBox(height: 12),
                 PerformanceCard(),
    SizedBox(height: 16),
    CoursesCard(),
              ],
            ),
          )
        ),

        ],
      )) ,
    );
  }
}