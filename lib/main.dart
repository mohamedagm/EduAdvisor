import 'package:edu_advisor/core/di/service_locator.dart';
import 'package:edu_advisor/core/routing/app_router.dart';
import 'package:edu_advisor/core/theme/app_theme.dart';
import 'package:edu_advisor/core/theme/theme_cubit.dart';
import 'package:edu_advisor/core/localization/language_cubit.dart';
import 'package:edu_advisor/core/localization/language_preferences.dart';
import 'package:edu_advisor/core/theme/theme_preferences.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  setupDependencyInjection();
  final preferences = await SharedPreferences.getInstance();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      availableLocales: AppLocalizations.supportedLocales,
      builder: (_) => MainApp(
        themePreferences: ThemePreferences(preferences),
        languagePreferences: LanguagePreferences(preferences),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    required this.themePreferences,
    required this.languagePreferences,
    super.key,
  });

  final ThemePreferences themePreferences;
  final LanguagePreferences languagePreferences;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppScreenUtil.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ThemeCubit(preferences: themePreferences),
          ),
          BlocProvider(
            create: (_) => LanguageCubit(preferences: languagePreferences),
          ),
        ],
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  // Required by device_preview 1.3.1's compatibility assertion.
                  // ignore: deprecated_member_use
                  useInheritedMediaQuery: true,
                  onGenerateTitle: (context) =>
                      AppLocalizations.of(context).appTitle,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: locale,
                  routerConfig: appRouter,
                  theme: AppTheme.light,
                  darkTheme: AppTheme.dark,
                  themeMode: themeMode,
                  themeAnimationDuration: const Duration(milliseconds: 250),
                  themeAnimationCurve: Curves.easeOut,
                  builder: (context, child) {
                    final brightness = Theme.of(context).brightness;
                    return AnnotatedRegion<SystemUiOverlayStyle>(
                      value: AppTheme.systemUiOverlayStyle(brightness),
                      child: DevicePreview.appBuilder(
                        context,
                        child ?? const SizedBox.shrink(),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
