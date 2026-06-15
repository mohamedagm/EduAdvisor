import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/features/auth/data/models/register_advisor_request_model.dart';
import 'package:edu_advisor/features/auth/data/models/register_student_request_model.dart';

class AuthRepo {
  const AuthRepo({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  Future<Either<ServerException, ApiResponseModel>> registerStudent(
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
      return Left(e);
    } catch (e) {
      return Left(ServerException(ApiResponseModel.message(e.toString())));
    }
  }

  Future<Either<ServerException, ApiResponseModel>> registerAdvisor(
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
      return Left(e);
    } catch (e) {
      return Left(ServerException(ApiResponseModel.message(e.toString())));
    }
  }
}
