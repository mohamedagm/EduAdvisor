import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/services/token_storage_service.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';

class AppStartupService {
  AppStartupService({
    TokenStorageService? tokenStorageService,
    ApiConsumer? apiConsumer,
  }) : _tokenStorageService = tokenStorageService ?? TokenStorageService(),
       _userRepo = UserRepo(apiConsumer: apiConsumer ?? DioConsumer());

  final TokenStorageService _tokenStorageService;
  final UserRepo _userRepo;

  Future<String> resolveInitialRoute() async {
    final accessToken = await _tokenStorageService.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      return AppRoutes.onboarding;
    }

    final result = await _userRepo.getMe();

    return result.fold<Future<String>>((failure) async {
      await _tokenStorageService.clearTokens();
      return AppRoutes.chooseUserRole;
    }, (user) async => _routeForRole(user.role));
  }

  String _routeForRole(String role) {
    switch (role.trim().toLowerCase()) {
      case 'student':
        return AppRoutes.studentMain;
      case 'advisor':
        return AppRoutes.advisorMain;
      default:
        return AppRoutes.chooseUserRole;
    }
  }
}
