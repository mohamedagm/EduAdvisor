import 'package:flutter/material.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.card,
    required this.mutedSurface,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.dangerContainer,
    required this.onDangerContainer,
    required this.purpleContainer,
    required this.onPurpleContainer,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.shadow,
  });

  final Color card;
  final Color mutedSurface;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color success;
  final Color onSuccess;
  final Color successContainer;
  final Color onSuccessContainer;
  final Color warning;
  final Color onWarning;
  final Color warningContainer;
  final Color onWarningContainer;
  final Color info;
  final Color onInfo;
  final Color infoContainer;
  final Color onInfoContainer;
  final Color dangerContainer;
  final Color onDangerContainer;
  final Color purpleContainer;
  final Color onPurpleContainer;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color shadow;

  static const light = AppThemeColors(
    card: Color(0xFFFFFFFF),
    mutedSurface: Color(0xFFF9FAFB),
    border: Color(0xFFE5E7EB),
    textPrimary: Color(0xFF101828),
    textSecondary: Color(0xFF4A5565),
    textMuted: Color(0xFF687280),
    success: Color(0xFF008236),
    onSuccess: Color(0xFFFFFFFF),
    successContainer: Color(0xFFF0FDF4),
    onSuccessContainer: Color(0xFF00662B),
    warning: Color(0xFFA85B00),
    onWarning: Color(0xFFFFFFFF),
    warningContainer: Color(0xFFFFF7D6),
    onWarningContainer: Color(0xFF7A4300),
    info: Color(0xFF155DFC),
    onInfo: Color(0xFFFFFFFF),
    infoContainer: Color(0xFFEFF6FF),
    onInfoContainer: Color(0xFF174EA6),
    dangerContainer: Color(0xFFFEF2F2),
    onDangerContainer: Color(0xFFC10007),
    purpleContainer: Color(0xFFFAF5FF),
    onPurpleContainer: Color(0xFF7E22CE),
    shimmerBase: Color(0xFFE5E7EB),
    shimmerHighlight: Color(0xFFF3F4F6),
    shadow: Color(0x1A101828),
  );

  static const dark = AppThemeColors(
    card: Color(0xFF111827),
    mutedSurface: Color(0xFF182233),
    border: Color(0xFF2A3648),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFFCBD5E1),
    textMuted: Color(0xFF94A3B8),
    success: Color(0xFF34D399),
    onSuccess: Color(0xFF052E22),
    successContainer: Color(0xFF123D32),
    onSuccessContainer: Color(0xFF86EFAC),
    warning: Color(0xFFFBBF24),
    onWarning: Color(0xFF422006),
    warningContainer: Color(0xFF422F12),
    onWarningContainer: Color(0xFFFDE68A),
    info: Color(0xFF60A5FA),
    onInfo: Color(0xFF0B2451),
    infoContainer: Color(0xFF172E55),
    onInfoContainer: Color(0xFFBFDBFE),
    dangerContainer: Color(0xFF491B20),
    onDangerContainer: Color(0xFFFCA5A5),
    purpleContainer: Color(0xFF321A46),
    onPurpleContainer: Color(0xFFD8B4FE),
    shimmerBase: Color(0xFF263244),
    shimmerHighlight: Color(0xFF3A4658),
    shadow: Color(0x66000000),
  );

  @override
  AppThemeColors copyWith({
    Color? card,
    Color? mutedSurface,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? dangerContainer,
    Color? onDangerContainer,
    Color? purpleContainer,
    Color? onPurpleContainer,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? shadow,
  }) {
    return AppThemeColors(
      card: card ?? this.card,
      mutedSurface: mutedSurface ?? this.mutedSurface,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
      dangerContainer: dangerContainer ?? this.dangerContainer,
      onDangerContainer: onDangerContainer ?? this.onDangerContainer,
      purpleContainer: purpleContainer ?? this.purpleContainer,
      onPurpleContainer: onPurpleContainer ?? this.onPurpleContainer,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  AppThemeColors lerp(covariant AppThemeColors? other, double t) {
    if (other == null) return this;

    return AppThemeColors(
      card: Color.lerp(card, other.card, t)!,
      mutedSurface: Color.lerp(mutedSurface, other.mutedSurface, t)!,
      border: Color.lerp(border, other.border, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      successContainer: Color.lerp(
        successContainer,
        other.successContainer,
        t,
      )!,
      onSuccessContainer: Color.lerp(
        onSuccessContainer,
        other.onSuccessContainer,
        t,
      )!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      warningContainer: Color.lerp(
        warningContainer,
        other.warningContainer,
        t,
      )!,
      onWarningContainer: Color.lerp(
        onWarningContainer,
        other.onWarningContainer,
        t,
      )!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t)!,
      onInfoContainer: Color.lerp(onInfoContainer, other.onInfoContainer, t)!,
      dangerContainer: Color.lerp(dangerContainer, other.dangerContainer, t)!,
      onDangerContainer: Color.lerp(
        onDangerContainer,
        other.onDangerContainer,
        t,
      )!,
      purpleContainer: Color.lerp(purpleContainer, other.purpleContainer, t)!,
      onPurpleContainer: Color.lerp(
        onPurpleContainer,
        other.onPurpleContainer,
        t,
      )!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(
        shimmerHighlight,
        other.shimmerHighlight,
        t,
      )!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  AppThemeColors get themeColors =>
      theme.extension<AppThemeColors>() ??
      (theme.brightness == Brightness.dark
          ? AppThemeColors.dark
          : AppThemeColors.light);
  bool get isDarkMode => theme.brightness == Brightness.dark;
}
