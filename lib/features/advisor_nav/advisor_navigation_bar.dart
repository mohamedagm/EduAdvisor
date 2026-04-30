

import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;

  const BottomNav({super.key, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selected,
      onDestinationSelected: onTap,
      backgroundColor: Colors.white,
      // indicatorColor: AppColors.primary.withOpacity(0.12),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.inbox_outlined),
          selectedIcon:
              Icon(Icons.inbox_rounded, color: AppColors.infoBlue),
          label: 'Requests',
        ),
        NavigationDestination(
          icon: Icon(Icons.people_outline),
          selectedIcon:
              Icon(Icons.people_rounded, color: AppColors.infoBlue),
          label: 'Students',
        ),
        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon:
              Icon(Icons.bar_chart_rounded, color: AppColors.infoBlue),
          label: 'Analytics',
        ),
      ],
    );
  }
}