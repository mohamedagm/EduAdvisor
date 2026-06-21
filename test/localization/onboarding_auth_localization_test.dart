import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:edu_advisor/valdations/valditors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('provides English and Arabic onboarding/auth messages', () async {
    final english = await AppLocalizations.delegate.load(const Locale('en'));
    final arabic = await AppLocalizations.delegate.load(const Locale('ar'));

    expect(english.trackYourProgress, 'Track Your Progress');
    expect(arabic.trackYourProgress, 'تابع تقدمك');
    expect(english.loginAsStudent, 'Login as student');
    expect(arabic.loginAsStudent, 'تسجيل الدخول كطالب');
    expect(english.resendIn(30), 'Resend in 30');
    expect(arabic.resendIn(30), 'إعادة الإرسال خلال 30');
    expect(Validators.email('', english), 'Email is required');
    expect(Validators.email('', arabic), 'البريد الإلكتروني مطلوب');
  });

  testWidgets('uses LTR for English and RTL for Arabic', (tester) async {
    TextDirection? direction;

    Future<void> pumpLocale(Locale locale) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              direction = Directionality.of(context);
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    await pumpLocale(const Locale('en'));
    expect(direction, TextDirection.ltr);

    await pumpLocale(const Locale('ar'));
    expect(direction, TextDirection.rtl);
  });
}
