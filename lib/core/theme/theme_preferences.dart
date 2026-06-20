import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  const ThemePreferences(this._preferences);

  static const _themeModeKey = 'theme_mode';

  final SharedPreferences _preferences;

  ThemeMode readThemeMode() {
    final storedMode = _preferences.getString(_themeModeKey);

    return ThemeMode.values.firstWhere(
      (mode) => mode.name == storedMode,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> saveThemeMode(ThemeMode mode) {
    return _preferences.setString(_themeModeKey, mode.name);
  }
}
