import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract final class SessionNavigation {
  static void studentSignedIn(BuildContext context) {
    context.go(AppRoutes.studentMain);
  }

  static void advisorSignedIn(BuildContext context) {
    context.go(AppRoutes.advisorMain);
  }

  static void signedOut(BuildContext context) {
    context.go(AppRoutes.chooseUserRole);
  }
}