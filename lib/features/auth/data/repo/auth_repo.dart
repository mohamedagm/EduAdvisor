import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/core/services/token_storage_service.dart';
import 'package:edu_advisor/core/services/user_cache_service.dart';
import 'package:edu_advisor/features/auth/data/models/login_request_model.dart';
import 'package:edu_advisor/features/auth/data/models/login_response_model.dart';
import 'package:edu_advisor/features/auth/data/models/register_advisor_request_model.dart';
import 'package:edu_advisor/features/auth/data/models/register_student_request_model.dart';

class AuthRepo {
  AuthRepo({
    required ApiConsumer apiConsumer,
    TokenStorageService? tokenStorageService,
    UserCacheService? userCacheService,
  }) : _apiConsumer = apiConsumer,
       _tokenStorageService = tokenStorageService ?? TokenStorageService(),
       _userCacheService = userCacheService ?? UserCacheService();

  final ApiConsumer _apiConsumer;
  final TokenStorageService _tokenStorageService;
  final UserCacheService _userCacheService;

  Future<Either<Failure, LoginResponseModel>> login(
    LoginRequestModel request, {
    required String expectedRole,
  }) async {
    try {
      await _tokenStorageService.clearTokens();
      await _userCacheService.clearCurrentUser();

      final response = await _apiConsumer.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final apiResponse = ApiResponseModel.fromJson(response);
      final loginResponse = LoginResponseModel.fromJson(
        Map<String, dynamic>.from(apiResponse.data as Map? ?? {}),
      );

      if (!_isExpectedRole(loginResponse.user.role, expectedRole)) {
        return Left(
          ServerFailure(
            ApiResponseModel.message(
              'This account is not a $expectedRole account',
              statusCode: 403,
            ),
          ),
        );
      }

      await _tokenStorageService.saveTokens(
        accessToken: loginResponse.accessToken,
        refreshToken: loginResponse.refreshToken,
        accessTokenExpiresAt: loginResponse.accessTokenExpiresAt,
        refreshTokenExpiresAt: loginResponse.refreshTokenExpiresAt,
      );

      return Right(loginResponse);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }

  bool _isExpectedRole(String actualRole, String expectedRole) {
    return actualRole.trim().toLowerCase() == expectedRole.trim().toLowerCase();
  }

  Future<Either<Failure, ApiResponseModel>> registerStudent(
    RegisterStudentRequestModel request,
  ) async {
    try {
      final response = await _apiConsumer.post(
        ApiEndpoints.registerStudent,
        data: request.toMap(),
        isFormData: true,
      );

      return Right(ApiResponseModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }

  Future<Either<Failure, ApiResponseModel>> registerAdvisor(
    RegisterAdvisorRequestModel request,
  ) async {
    try {
      final response = await _apiConsumer.post(
        ApiEndpoints.registerAdvisor,
        data: request.toMap(),
        isFormData: true,
      );

      return Right(ApiResponseModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }

  Future<Either<Failure, ApiResponseModel>> logout() async {
    try {
      final refreshToken = await _tokenStorageService.getRefreshToken();

      if (refreshToken == null || refreshToken.isEmpty) {
        await _tokenStorageService.clearTokens();
        await _userCacheService.clearCurrentUser();
        return const Right(
          ApiResponseModel(
            isSuccess: true,
            message: 'Logged out successfully',
            statusCode: 200,
          ),
        );
      }

      final response = await _apiConsumer.post(
        ApiEndpoints.logout,
        data: {'refreshToken': refreshToken},
      );

      await _tokenStorageService.clearTokens();
      await _userCacheService.clearCurrentUser();

      final apiResponse = response is Map
          ? ApiResponseModel.fromJson(Map<String, dynamic>.from(response))
          : const ApiResponseModel(
              isSuccess: true,
              message: 'Logged out successfully',
              statusCode: 200,
            );

      return Right(apiResponse);
    } on ServerException catch (e) {
      await _tokenStorageService.clearTokens();
      await _userCacheService.clearCurrentUser();
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      await _tokenStorageService.clearTokens();
      await _userCacheService.clearCurrentUser();
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}
