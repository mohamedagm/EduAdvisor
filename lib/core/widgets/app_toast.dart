import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';

class AppToast {
  const AppToast._();

  static void success(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    _show(
      context,
      title: title,
      description: description,
      icon: Icons.check_rounded,
      accentColor: context.themeColors.success,
      accentContainer: context.themeColors.successContainer,
    );
  }

  static void error(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    _show(
      context,
      title: title,
      description: description,
      icon: Icons.close_rounded,
      accentColor: context.colorScheme.error,
      accentContainer: context.themeColors.dangerContainer,
    );
  }

  static void warning(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    _show(
      context,
      title: title,
      description: description,
      icon: Icons.warning_amber_rounded,
      accentColor: context.themeColors.warning,
      accentContainer: context.themeColors.warningContainer,
    );
  }

  static void info(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    _show(
      context,
      title: title,
      description: description,
      icon: Icons.info_outline_rounded,
      accentColor: context.themeColors.info,
      accentContainer: context.themeColors.infoContainer,
    );
  }

  static void _show(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color accentColor,
    required Color accentContainer,
  }) {
    final themeColors = context.themeColors;

    CherryToast(
      themeColor: accentColor,
      iconWidget: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: accentContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: accentColor, size: 20),
      ),
      title: Text(
        title,
        style: AppTextStyles.bodyInterMedium14.copyWith(
          color: themeColors.textPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
      description: Text(
        description,
        style: AppTextStyles.bodyInterRegular12.copyWith(
          color: themeColors.textSecondary,
          height: 1.4,
        ),
      ),
      backgroundColor: themeColors.card,
      shadowColor: themeColors.shadow,
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 350),
      animationCurve: Curves.easeOutCubic,
      toastDuration: const Duration(seconds: 3),
      borderRadius: 16,
      constraints: const BoxConstraints(maxWidth: 440),
      textDirection: Directionality.of(context),
      disableToastAnimation:
          MediaQuery.maybeOf(context)?.disableAnimations ?? false,
      titleDescriptionMargin: 4,
      horizontalAlignment: CrossAxisAlignment.start,
    ).show(context);
  }
}
