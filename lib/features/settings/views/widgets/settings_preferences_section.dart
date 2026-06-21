import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/core/theme/theme_cubit.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_card.dart';
import 'package:edu_advisor/features/settings/views/widgets/settings_info_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPreferencesSection extends StatelessWidget {
  const SettingsPreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return SettingsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.preferences,
            style: AppTextStyles.bodyInterMedium18.responsive.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
          SizedBox(height: 16.w),
          SettingsInfoRow(
            icon: Icons.language_outlined,
            title: context.l10n.language,
            subtitle: isArabic
                ? context.l10n.arabicLanguage
                : context.l10n.englishLanguage,
          ),
          SizedBox(height: 20.w),
          Text(
            context.l10n.appearance,
            style: AppTextStyles.bodyInterMedium14.responsive.copyWith(
              color: context.themeColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.w),
          Text(
            context.l10n.appearanceDescription,
            style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
              color: context.themeColors.textMuted,
            ),
          ),
          SizedBox(height: 12.w),
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
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: context.themeColors.mutedSurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: context.themeColors.border),
      ),
      child: Row(
        children: [
          _ThemeModeOption(
            label: context.l10n.systemTheme,
            icon: Icons.brightness_auto_outlined,
            isSelected: selectedMode == ThemeMode.system,
            onTap: () => onSelected(ThemeMode.system),
          ),
          _ThemeModeOption(
            label: context.l10n.lightTheme,
            icon: Icons.light_mode_outlined,
            isSelected: selectedMode == ThemeMode.light,
            onTap: () => onSelected(ThemeMode.light),
          ),
          _ThemeModeOption(
            label: context.l10n.darkTheme,
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
        label: context.l10n.themeOptionSemantics(label),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(9.r),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 4.w),
            decoration: BoxDecoration(
              color: isSelected
                  ? context.colorScheme.primary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(9.r),
            ),
            child: Column(
              children: [
                Icon(icon, size: 18.r, color: foreground),
                SizedBox(height: 4.w),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodyInterRegular12.responsive.copyWith(
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
