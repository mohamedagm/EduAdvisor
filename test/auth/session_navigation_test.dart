import 'package:edu_advisor/core/routing/app_router.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/routing/session_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  test('registers both role login screens in GoRouter', () {
    final paths = appRouter.configuration.routes.whereType<GoRoute>().map(
      (route) => route.path,
    );

    expect(
      paths,
      containsAll([AppRoutes.studentLogin, AppRoutes.advisorLogin]),
    );
  });

  testWidgets(
    'clears both advisor and student sessions when roles are switched',
    (tester) async {
      late final GoRouter router;

      router = GoRouter(
        initialLocation: AppRoutes.chooseUserRole,
        routes: [
          GoRoute(
            path: AppRoutes.chooseUserRole,
            builder: (context, state) => _TestPage(
              label: 'choose-role',
              actions: {
                'advisor-login': () =>
                    SessionNavigation.advisorSignedIn(context),
                'student-login': () =>
                    SessionNavigation.studentSignedIn(context),
              },
            ),
          ),
          GoRoute(
            path: AppRoutes.advisorProfileSetup,
            builder: (context, state) => _TestPage(
              label: 'advisor-profile',
              actions: {
                'finish-profile': () => context.go(AppRoutes.advisorMain),
              },
            ),
          ),
          GoRoute(
            path: AppRoutes.advisorMain,
            builder: (context, state) => _TestPage(
              label: 'advisor-main',
              actions: {
                'advisor-logout': () => SessionNavigation.signedOut(context),
              },
            ),
          ),
          GoRoute(
            path: AppRoutes.studentMain,
            builder: (context, state) => _TestPage(
              label: 'student-main',
              actions: {
                'open-settings': () => context.push(AppRoutes.settings),
              },
            ),
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => _TestPage(
              label: 'settings',
              actions: {
                'student-logout': () => SessionNavigation.signedOut(context),
              },
            ),
          ),
        ],
      );
      addTearDown(router.dispose);

      await tester.pumpWidget(MaterialApp.router(routerConfig: router));

      await tester.tap(find.text('advisor-login'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('finish-profile'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('advisor-logout'));
      await tester.pumpAndSettle();
      expect(find.text('choose-role'), findsOneWidget);

      await tester.tap(find.text('student-login'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('open-settings'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('student-logout'));
      await tester.pumpAndSettle();

      expect(find.text('choose-role'), findsOneWidget);
      expect(find.text('student-main'), findsNothing);
      expect(find.text('settings'), findsNothing);
      expect(router.canPop(), isFalse);
    },
  );
}

class _TestPage extends StatelessWidget {
  const _TestPage({required this.label, required this.actions});

  final String label;
  final Map<String, VoidCallback> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(label),
          for (final action in actions.entries)
            TextButton(onPressed: action.value, child: Text(action.key)),
        ],
      ),
    );
  }
}
