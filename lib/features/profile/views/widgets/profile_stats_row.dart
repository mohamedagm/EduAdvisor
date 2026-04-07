import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/features/profile/views/widgets/profile_Stat_card.dart';
import 'package:flutter/material.dart';

class ProfileStatsRow extends StatelessWidget {
  const ProfileStatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ProfileStatCard(
          title: "GPA",
          value: "3.45",
          icon: Icons.emoji_events,
          iconColor: AppColors.bluePrimary,
        ),
        ProfileStatCard(
          title: "Credits",
          value: "45",
          icon: Icons.menu_book,
          iconColor: AppColors.purplePrimary,
        ),
        ProfileStatCard(
          title: "Semester",
          value: "4",
          icon: Icons.calendar_month,
          iconColor: AppColors.aiPink,
        ),
      ],
    );
  }
}
