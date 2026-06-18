import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/services/data/models/available_course_model.dart';

class CourseRegistrationRepo {
  const CourseRegistrationRepo({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  Future<Either<Failure, List<AvailableCourseModel>>>
  getAvailableCourses() async {
    try {
      final response = await _apiConsumer.get(ApiEndpoints.availableCourses);
      final apiResponse = ApiResponseModel.fromJson(response);
      final courses = apiResponse.data as List? ?? [];

      return Right(
        courses
            .map(
              (course) => AvailableCourseModel.fromJson(
                Map<String, dynamic>.from(course as Map? ?? {}),
              ),
            )
            .toList(),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}
