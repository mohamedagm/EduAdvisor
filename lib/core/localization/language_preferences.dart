import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  const LanguagePreferences(this._preferences);

  static const _languageCodeKey = 'language_code';

  final SharedPreferences _preferences;

  Locale readLocale() {
    final storedCode = _preferences.getString(_languageCodeKey);

    if (storedCode == null || storedCode.isEmpty) {
      return const Locale('ar');
    }

    return Locale(storedCode);
  }

  Future<void> saveLocale(Locale locale) {
    return _preferences.setString(_languageCodeKey, locale.languageCode);
  }
}
