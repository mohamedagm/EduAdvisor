import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/theme/app_theme.dart';
import 'package:edu_advisor/core/utils/app_screen_util.dart';
import 'package:edu_advisor/features/home/views/home_view.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_cubit.dart';
import 'package:edu_advisor/features/user/manager/current_user_cubit/current_user_state.dart';
import 'package:edu_advisor/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final scenarios = <({String name, Size size, Locale locale})>[
    (
      name: 'small Arabic phone',
      size: const Size(320, 568),
      locale: const Locale('ar'),
    ),
    (
      name: 'reference English phone',
      size: AppScreenUtil.designSize,
      locale: const Locale('en'),
    ),
    (
      name: 'large Arabic tablet',
      size: const Size(800, 1280),
      locale: const Locale('ar'),
    ),
  ];

  for (final scenario in scenarios) {
    testWidgets('Home has no overflow on ${scenario.name}', (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = scenario.size;
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.view.resetPhysicalSize);

      final currentUserCubit = _LoadedCurrentUserCubit();
      addTearDown(currentUserCubit.close);

      await tester.pumpWidget(
        ScreenUtilInit(
          designSize: AppScreenUtil.designSize,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, _) => BlocProvider<CurrentUserCubit>.value(
            value: currentUserCubit,
            child: MaterialApp(
              locale: scenario.locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: AppTheme.light,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(disableAnimations: true),
                child: child!,
              ),
              home: const Scaffold(body: HomeView()),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.byType(HomeView), findsOneWidget);
    });
  }
}

class _LoadedCurrentUserCubit extends CurrentUserCubit {
  _LoadedCurrentUserCubit()
    : super(userRepo: UserRepo(apiConsumer: DioConsumer())) {
    emit(const CurrentUserLoaded(_user));
  }

  static const _user = CurrentUserModel(
    id: 'student-1',
    fullName: 'Responsive Test Student',
    email: 'student@example.com',
    role: 'student',
    isVerified: true,
    gpa: 3.7,
    completedCreditHours: 65,
    level: 3,
    rawData: {},
  );
}
