import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/core/services/token_storage_service.dart';
import 'package:edu_advisor/features/auth/data/models/login_request_model.dart';
import 'package:edu_advisor/features/auth/data/models/login_response_model.dart';
import 'package:edu_advisor/features/auth/data/models/register_advisor_request_model.dart';
import 'package:edu_advisor/features/auth/data/models/register_student_request_model.dart';

class AuthRepo {
  AuthRepo({
    required ApiConsumer apiConsumer,
    TokenStorageService? tokenStorageService,
  }) : _apiConsumer = apiConsumer,
       _tokenStorageService = tokenStorageService ?? TokenStorageService();

  final ApiConsumer _apiConsumer;
  final TokenStorageService _tokenStorageService;

  Future<Either<Failure, LoginResponseModel>> login(
    LoginRequestModel request,
  ) async {
    try {
      final response = await _apiConsumer.post(
        ApiEndpoints.login,
        data: request.toJson(),
      );

      final apiResponse = ApiResponseModel.fromJson(response);
      final loginResponse = LoginResponseModel.fromJson(
        Map<String, dynamic>.from(apiResponse.data as Map? ?? {}),
      );

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
}
