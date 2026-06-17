import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/core/services/user_cache_service.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';

class UserRepo {
  UserRepo({
    required ApiConsumer apiConsumer,
    UserCacheService? userCacheService,
  }) : _apiConsumer = apiConsumer,
       _userCacheService = userCacheService ?? UserCacheService();

  final ApiConsumer _apiConsumer;
  final UserCacheService _userCacheService;

  Future<CurrentUserModel?> getCachedMe() async {
    try {
      final cachedUser = await _userCacheService.getCurrentUser();
      if (cachedUser == null) {
        return null;
      }

      return CurrentUserModel.fromJson(cachedUser);
    } catch (_) {
      await _userCacheService.clearCurrentUser();
      return null;
    }
  }

  Future<Either<Failure, CurrentUserModel>> getMe() async {
    try {
      final response = await _apiConsumer.get(ApiEndpoints.me);
      final apiResponse = ApiResponseModel.fromJson(response);
      final userData = Map<String, dynamic>.from(
        apiResponse.data as Map? ?? {},
      );

      await _userCacheService.saveCurrentUser(userData);

      return Right(CurrentUserModel.fromJson(userData));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}
