import 'package:flutter/material.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class BottomNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;

  const BottomNav({super.key, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selected,
      onDestinationSelected: onTap,
      backgroundColor: context.themeColors.card,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.inbox_outlined),
          selectedIcon: Icon(
            Icons.inbox_rounded,
            color: context.themeColors.info,
          ),
          label: 'Requests',
        ),
        NavigationDestination(
          icon: Icon(Icons.people_outline),
          selectedIcon: Icon(
            Icons.people_rounded,
            color: context.themeColors.info,
          ),
          label: 'Students',
        ),
        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(
            Icons.bar_chart_rounded,
            color: context.themeColors.info,
          ),
          label: 'Analytics',
        ),
      ],
    );
  }
}
