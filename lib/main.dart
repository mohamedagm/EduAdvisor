import 'package:edu_advisor/core/routing/app_router.dart';
import 'package:edu_advisor/core/theme/app_theme.dart';
import 'package:edu_advisor/core/theme/theme_cubit.dart';
import 'package:edu_advisor/core/theme/theme_preferences.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  final preferences = await SharedPreferences.getInstance();
  runApp(MainApp(themePreferences: ThemePreferences(preferences)));
}

class MainApp extends StatelessWidget {
  const MainApp({required this.themePreferences, super.key});

  final ThemePreferences themePreferences;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppScreenUtil.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => BlocProvider(
        create: (_) => ThemeCubit(preferences: themePreferences),
        child: BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context).appTitle,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: AppLocalizations.supportedLocales.first,
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
                  child: child ?? const SizedBox.shrink(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
