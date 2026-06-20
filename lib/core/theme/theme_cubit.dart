import 'package:edu_advisor/core/theme/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit({required ThemePreferences preferences})
    : _preferences = preferences,
      super(preferences.readThemeMode());

  final ThemePreferences _preferences;

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state == mode) return;

    emit(mode);
    try {
      await _preferences.saveThemeMode(mode);
    } catch (_) {
      // The selected mode remains active for this session if persistence fails.
    }
  }
}
