// forgot_password_repo.dart
import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';

class ForgotPasswordRepo {
  ForgotPasswordRepo({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  Future<Either<Failure, ApiResponseModel>> sendOtp({
    required String email,
  }) async {
    try {
      final response = await _apiConsumer.post(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );
      return Right(ApiResponseModel.fromJson(response));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}