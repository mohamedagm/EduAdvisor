import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart'; // 👈 إمبورت لملف الـ Endpoints بتاعك
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';

class ResetPasswordRepo {
  final ApiConsumer _apiConsumer;

  ResetPasswordRepo({
    required ApiConsumer apiConsumer,
  }) : _apiConsumer = apiConsumer;

  Future<Either<Failure, ApiResponseModel>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await _apiConsumer.post(
        ApiEndpoints.resetPassword, 
        data: {
          "email": email,
          "token": token,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        },
      );

      return Right(ApiResponseModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}