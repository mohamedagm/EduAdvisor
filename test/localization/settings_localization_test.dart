import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('provides English and Arabic settings translations', () async {
    final english = await AppLocalizations.delegate.load(const Locale('en'));
    final arabic = await AppLocalizations.delegate.load(const Locale('ar'));

    expect(english.settingsTitle, 'Settings');
    expect(arabic.settingsTitle, 'الإعدادات');
    expect(english.profileInformation, 'Profile Information');
    expect(arabic.profileInformation, 'معلومات الملف الشخصي');
    expect(english.pushNotifications, 'Push Notifications');
    expect(arabic.pushNotifications, 'الإشعارات الفورية');
    expect(english.themeOptionSemantics('Dark'), 'Dark theme');
    expect(arabic.themeOptionSemantics('داكن'), 'المظهر داكن');
    expect(english.loggingOut, 'Logging out...');
    expect(arabic.loggingOut, 'جارٍ تسجيل الخروج...');
  });
}
