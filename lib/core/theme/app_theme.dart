import 'package:edu_advisor/core/theme/app_colors.dart';
import 'package:edu_advisor/core/theme/app_text_styles.dart';
import 'package:edu_advisor/core/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData get light => _build(
    brightness: Brightness.light,
    scheme:
        ColorScheme.fromSeed(
          seedColor: AppColors.bluePrimary,
          brightness: Brightness.light,
        ).copyWith(
          primary: AppColors.infoBlue,
          onPrimary: AppColors.white,
          secondary: AppColors.purplePrimary,
          onSecondary: AppColors.white,
          error: AppColors.errorRed,
          onError: AppColors.white,
          surface: AppColors.gray50,
          onSurface: AppColors.gray800,
          onSurfaceVariant: AppColors.gray600,
          outline: AppColors.gray300,
          outlineVariant: AppColors.gray200,
          surfaceContainerLowest: AppColors.white,
          surfaceContainerLow: AppColors.gray50,
          surfaceContainer: AppColors.gray100,
          surfaceContainerHigh: AppColors.gray200,
        ),
    semantic: AppThemeColors.light,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    scheme:
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF60A5FA),
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFF60A5FA),
          onPrimary: const Color(0xFF071A3B),
          secondary: const Color(0xFFC084FC),
          onSecondary: const Color(0xFF2E0B4F),
          error: const Color(0xFFF87171),
          onError: const Color(0xFF450A0A),
          surface: const Color(0xFF0B1220),
          onSurface: const Color(0xFFF8FAFC),
          onSurfaceVariant: const Color(0xFFCBD5E1),
          outline: const Color(0xFF344154),
          outlineVariant: const Color(0xFF273449),
          surfaceContainerLowest: const Color(0xFF0B1220),
          surfaceContainerLow: const Color(0xFF111827),
          surfaceContainer: const Color(0xFF182233),
          surfaceContainerHigh: const Color(0xFF202B3C),
        ),
    semantic: AppThemeColors.dark,
  );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme scheme,
    required AppThemeColors semantic,
  }) {
    final isDark = brightness == Brightness.dark;
    final textTheme = _textTheme(scheme);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      fontFamily: 'Inter',
      textTheme: textTheme,
      extensions: [semantic],
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: systemUiOverlayStyle(brightness),
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: semantic.card,
        surfaceTintColor: Colors.transparent,
        shape: shape.copyWith(side: BorderSide(color: semantic.border)),
        margin: EdgeInsets.zero,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: semantic.card,
        selectedItemColor: semantic.info,
        unselectedItemColor: semantic.textMuted,
        type: BottomNavigationBarType.fixed,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: semantic.card,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: semantic.card,
        modalBarrierColor: Colors.black.withValues(alpha: 0.55),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: semantic.card,
        surfaceTintColor: Colors.transparent,
        shape: shape,
      ),
      dividerTheme: DividerThemeData(color: semantic.border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: semantic.mutedSurface,
        hintStyle: textTheme.bodyMedium?.copyWith(color: semantic.textMuted),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: semantic.textSecondary,
        ),
        prefixIconColor: semantic.textMuted,
        suffixIconColor: semantic.textMuted,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: semantic.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: semantic.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: textTheme.labelLarge,
        ),
      ),
      iconTheme: IconThemeData(color: semantic.textSecondary),
      chipTheme: ChipThemeData(
        backgroundColor: semantic.mutedSurface,
        selectedColor: scheme.primaryContainer,
        side: BorderSide(color: semantic.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelStyle: textTheme.labelMedium,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.primary,
        linearTrackColor: scheme.surfaceContainerHigh,
        circularTrackColor: scheme.surfaceContainerHigh,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark
            ? scheme.surfaceContainerHigh
            : AppColors.gray800,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.onPrimary
              : semantic.textMuted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? scheme.primary
              : scheme.surfaceContainerHigh,
        ),
      ),
    );
  }

  static TextTheme _textTheme(ColorScheme scheme) {
    return TextTheme(
      headlineMedium: AppTextStyles.heading1_20b.copyWith(
        fontSize: 28,
        color: scheme.onSurface,
      ),
      headlineSmall: AppTextStyles.heading1_20b.copyWith(
        color: scheme.onSurface,
      ),
      titleLarge: AppTextStyles.heading2PoppinsSb18.copyWith(
        color: scheme.onSurface,
      ),
      titleMedium: AppTextStyles.heading3PoppinsReg16.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: AppTextStyles.interRegular16.copyWith(color: scheme.onSurface),
      bodyMedium: AppTextStyles.bodyInterMedium14.copyWith(
        color: scheme.onSurface,
      ),
      bodySmall: AppTextStyles.bodyInterRegular12.copyWith(
        color: scheme.onSurfaceVariant,
      ),
      labelLarge: AppTextStyles.bodyInterMedium14.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: AppTextStyles.bodyInterRegular12.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  static SystemUiOverlayStyle systemUiOverlayStyle(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final background = isDark
        ? const Color(0xFF0B1220)
        : const Color(0xFFF9FAFB);

    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: background,
      systemNavigationBarIconBrightness: isDark
          ? Brightness.light
          : Brightness.dark,
    );
  }
}
