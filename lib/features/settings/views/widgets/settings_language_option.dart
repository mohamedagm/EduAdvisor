import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';

class SettingsLanguageOption extends StatelessWidget {
  const SettingsLanguageOption({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected
        ? context.colorScheme.onPrimary
        : context.themeColors.textSecondary;

    return Expanded(
      child: Semantics(
        button: true,
        selected: isSelected,
        label: label,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(9),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              children: [
                Icon(icon, size: 18, color: foreground),
                const SizedBox(height: 4),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyInterRegular12
                      .copyWith(
                        color: foreground,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      )
                      .merge(AppTextStyles.bodyInterRegular12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
