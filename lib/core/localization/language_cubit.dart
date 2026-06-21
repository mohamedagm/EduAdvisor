import 'package:edu_advisor/core/localization/language_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit({required LanguagePreferences preferences})
    : _preferences = preferences,
      super(preferences.readLocale());

  final LanguagePreferences _preferences;

  Future<void> setLocale(Locale locale) async {
    if (state == locale) return;

    emit(locale);
    try {
      await _preferences.saveLocale(locale);
    } catch (_) {
      // Keep selected locale for this session if persistence fails.
    }
  }
}
