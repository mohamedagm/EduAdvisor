import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';

class ServiceAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subtitle;

  const ServiceAppBar({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.themeColors.card,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.themeColors.textPrimary),
        onPressed: () => context.pop(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.heading1_20b.copyWith(
              color: context.themeColors.textPrimary,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyles.bodyInterRegular12.copyWith(
              color: context.themeColors.textMuted,
            ),
          ),
        ],
      ),
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: context.themeColors.border, height: 1.0),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0);
}
