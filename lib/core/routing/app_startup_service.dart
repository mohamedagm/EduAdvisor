import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/dio_consumer.dart';
import 'package:edu_advisor/core/routing/app_routes.dart';
import 'package:edu_advisor/core/services/token_storage_service.dart';
import 'package:edu_advisor/core/services/user_cache_service.dart';
import 'package:edu_advisor/features/user/data/repo/user_repo.dart';

class AppStartupService {
  AppStartupService({
    TokenStorageService? tokenStorageService,
    UserCacheService? userCacheService,
    ApiConsumer? apiConsumer,
  }) : _tokenStorageService = tokenStorageService ?? TokenStorageService(),
       _userCacheService = userCacheService ?? UserCacheService(),
       _userRepo = UserRepo(apiConsumer: apiConsumer ?? DioConsumer());

  final TokenStorageService _tokenStorageService;
  final UserCacheService _userCacheService;
  final UserRepo _userRepo;

  Future<String> resolveInitialRoute() async {
    final accessToken = await _tokenStorageService.getAccessToken();

    if (accessToken == null || accessToken.isEmpty) {
      await _userCacheService.clearCurrentUser();
      return AppRoutes.onboarding;
    }

    final result = await _userRepo.getMe();

    return result.fold<Future<String>>((failure) async {
      await _tokenStorageService.clearTokens();
      await _userCacheService.clearCurrentUser();
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
