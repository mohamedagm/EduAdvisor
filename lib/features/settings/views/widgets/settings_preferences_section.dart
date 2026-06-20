import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/theme/theme_cubit.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPreferencesSection extends StatelessWidget {
  const SettingsPreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preferences',
            style: AppTextStyles.bodyInterMedium18.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          const SettingsInfoRow(
            icon: Icons.language_outlined,
            title: 'Language',
            subtitle: 'English',
          ),
          const SizedBox(height: 20),
          Text(
            'Appearance',
            style: AppTextStyles.bodyInterMedium14.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Choose how EduAdvisor looks on this device',
            style: AppTextStyles.bodyInterRegular12.copyWith(
              color: context.themeColors.textMuted,
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return _ThemeModeSelector(
                selectedMode: themeMode,
                onSelected: context.read<ThemeCubit>().setThemeMode,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ThemeModeSelector extends StatelessWidget {
  const _ThemeModeSelector({
    required this.selectedMode,
    required this.onSelected,
  });

  final ThemeMode selectedMode;
  final ValueChanged<ThemeMode> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: context.themeColors.mutedSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Row(
        children: [
          _ThemeModeOption(
            label: 'System',
            icon: Icons.brightness_auto_outlined,
            isSelected: selectedMode == ThemeMode.system,
            onTap: () => onSelected(ThemeMode.system),
          ),
          _ThemeModeOption(
            label: 'Light',
            icon: Icons.light_mode_outlined,
            isSelected: selectedMode == ThemeMode.light,
            onTap: () => onSelected(ThemeMode.light),
          ),
          _ThemeModeOption(
            label: 'Dark',
            icon: Icons.dark_mode_outlined,
            isSelected: selectedMode == ThemeMode.dark,
            onTap: () => onSelected(ThemeMode.dark),
          ),
        ],
      ),
    );
  }
}

class _ThemeModeOption extends StatelessWidget {
  const _ThemeModeOption({
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
        label: '$label theme',
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
                  style: AppTextStyles.bodyInterRegular12.copyWith(
                    color: foreground,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
