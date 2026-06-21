import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('provides English and Arabic profile translations', () async {
    final english = await AppLocalizations.delegate.load(const Locale('en'));
    final arabic = await AppLocalizations.delegate.load(const Locale('ar'));

    expect(english.myProfile, 'My Profile');
    expect(arabic.myProfile, 'ملفي الشخصي');
    expect(english.profileStudentId('123'), 'ID: 123');
    expect(arabic.profileStudentId('123'), 'المعرّف: 123');
    expect(english.creditsRemaining(75), '75 credits remaining');
    expect(arabic.creditsRemaining(75), '75 ساعة معتمدة متبقية');
    expect(english.unreadNotifications(2), '2 unread notifications');
    expect(arabic.unreadNotifications(2), 'إشعاران غير مقروءين');
    expect(english.hoursAgo(2), '2 hours ago');
    expect(arabic.hoursAgo(2), 'منذ ساعتين');
  });
}
