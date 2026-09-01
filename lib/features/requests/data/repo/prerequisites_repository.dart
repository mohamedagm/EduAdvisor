import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/requests/models/prerequisite_model.dart';

class PrerequisitesRepository {
  final ApiConsumer _apiConsumer;

  PrerequisitesRepository({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  /// Get Prerequisites for a course by its semesterCourseId
  Future<Either<Failure, List<PrerequisiteCourseModel>>> getCoursePrerequisites(
  String semesterCourseId,
) async {
  try {
    final response = await _apiConsumer.get(
      ApiEndpoints.getCoursePrerequisites,
      queryParameters: {'courseId': semesterCourseId},
    );

    final apiResponse = ApiResponseModel.fromJson(response);
    final List rawList = apiResponse.data as List? ?? [];

    final prerequisitesList = rawList
        .map((e) => PrerequisiteCourseModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();

    return Right(prerequisitesList);
  } on ServerException catch (e) {
   
    if (e.apiResponse.statusCode == 404) {
      return const Right([]);
    }
    return Left(ServerFailure(e.apiResponse));
  } catch (e) {
    return Left(ServerFailure(ApiResponseModel.message(e.toString())));
  }
}
}