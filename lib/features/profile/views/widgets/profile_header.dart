import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_gradiants.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/features/profile/views/notifications_view.dart';
import 'package:edu_advisor/features/profile/views/settings_view.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      decoration: const BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Profile",
                style: AppTextStyles.heading1_20b.copyWith(
                  color: AppColors.white,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationsView(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.notifications_none,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),

                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsView()),
                      );
                    },
                    icon: Icon(
                      Icons.settings,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [
              const CircleAvatar(
                radius: 35,
                child: Icon(Icons.person, size: 40),
              ),

              const SizedBox(width: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aliaa Mohamed",
                    style: AppTextStyles.heading3PoppinsReg16.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "ID: 2020345",
                    style: AppTextStyles.bodyInterMedium14.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Chip(
                    backgroundColor: AppColors.infoBlue.withValues(alpha: 0.8),
                    label: Text(
                      "Information System",
                      style: AppTextStyles.bodyInterRegular12.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
