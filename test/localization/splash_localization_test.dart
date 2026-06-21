import 'package:edu_advisor/core/localization/localization_extensions.dart';
import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('provides the English splash translations', (tester) async {
    await tester.pumpWidget(_translationProbe(const Locale('en')));

    expect(find.text('EduAdvisor'), findsOneWidget);
    expect(find.text('Your AI-Powered Academic Companion'), findsOneWidget);
    expect(find.text('Smart Planning'), findsOneWidget);
    expect(find.text('AI Powered'), findsOneWidget);
  });

  testWidgets('provides the Arabic splash translations', (tester) async {
    await tester.pumpWidget(_translationProbe(const Locale('ar')));

    expect(find.text('المرشد الأكاديمي'), findsOneWidget);
    expect(
      find.text('رفيقك الأكاديمي المدعوم بالذكاء الاصطناعي'),
      findsOneWidget,
    );
    expect(find.text('تخطيط ذكي'), findsOneWidget);
    expect(find.text('مدعوم بالذكاء الاصطناعي'), findsOneWidget);
  });
}

Widget _translationProbe(Locale locale) {
  return MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Builder(
      builder: (context) => Scaffold(
        body: Column(
          children: [
            Text(context.l10n.appTitle),
            Text(context.l10n.splashTagline),
            Text(context.l10n.smartPlanning),
            Text(context.l10n.aiPowered),
          ],
        ),
      ),
    ),
  );
}
