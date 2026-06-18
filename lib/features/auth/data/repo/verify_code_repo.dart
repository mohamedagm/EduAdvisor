import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';

class VerifyCodeRepo {
  VerifyCodeRepo({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  Future<Either<Failure, ApiResponseModel>> verifyOtp({
    required String email,
    required String code,
  }) async {
    try {
      final response = await _apiConsumer.post(
        ApiEndpoints.confirmEmail,
        data: {
          'email': email,
          'otp': code,
        },
      );

      return Right(ApiResponseModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(
        ServerFailure(ApiResponseModel.message(e.toString())),
      );
    }
  }

  Future<Either<Failure, ApiResponseModel>> resendOtp({
    required String email,
  }) async {
    try {
      final response = await _apiConsumer.post(
        ApiEndpoints.resendVerification,
        data: {
          'email': email,
        },
      );

      return Right(ApiResponseModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(
        ServerFailure(ApiResponseModel.message(e.toString())),
      );
    }
  }


  Future<Either<Failure, ApiResponseModel>> verifyResetOtp({
  required String email,
  required String code,
}) async {
  try {
    final response = await _apiConsumer.post(
      ApiEndpoints.verifyResetOtp, // ✅ endpoint مختلف
      data: {'email': email, 'otp': code},
    );
    return Right(ApiResponseModel.fromJson(response));
  } on ServerException catch (e) {
    return Left(ServerFailure(e.apiResponse));
  }
}
}