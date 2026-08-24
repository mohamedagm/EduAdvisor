import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/profile/data/models/student_enrollment_model.dart';

class ProfileCoursesRepo {
  const ProfileCoursesRepo({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  Future<Either<Failure, List<StudentEnrollmentModel>>> getEnrollments({
    bool? isPassed,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {};
      if (isPassed != null) {
        queryParameters['isPassed'] = isPassed;
      }

      final response = await _apiConsumer.get(
        ApiEndpoints.studentEnrollments,
        queryParameters: queryParameters,
      );
      final apiResponse = ApiResponseModel.fromJson(response);
      final data = apiResponse.data as List? ?? [];

      return Right(
        data
            .map(
              (e) => StudentEnrollmentModel.fromJson(
                Map<String, dynamic>.from(e as Map? ?? {}),
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
