import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/requests/models/available_courses_model.dart';

class AvailableCoursesRepo {
  final ApiConsumer _apiConsumer;

  AvailableCoursesRepo({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  Future<Either<Failure, StudentAvailableCoursesModel>> getAvailableCourses(
    String studentId,
  ) async {
    try {
      final response = await _apiConsumer.get(
        ApiEndpoints.getAvailableCourses(studentId), 
      );

      final apiResponse = ApiResponseModel.fromJson(response);
      final dataMap = apiResponse.data as Map<String, dynamic>? ?? {};

      return Right(StudentAvailableCoursesModel.fromJson(dataMap));
    } on ServerException catch (e) {
      if (e.apiResponse.statusCode == 404) {
        return Right(StudentAvailableCoursesModel.empty());
      }
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}