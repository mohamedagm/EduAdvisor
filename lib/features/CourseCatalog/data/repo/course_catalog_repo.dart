import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/CourseCatalog/data/models/course_catalog_page_model.dart';
import 'package:edu_advisor/features/CourseCatalog/data/models/course_catalog_query_params.dart';

class CourseCatalogRepo {
  const CourseCatalogRepo({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  Future<Either<Failure, CourseCatalogPageModel>> getCourses({
    CourseCatalogQueryParams? queryParams,
  }) async {
    try {
      final response = await _apiConsumer.get(
        ApiEndpoints.courses,
        queryParameters: queryParams?.toMap(),
      );

      final apiResponse = ApiResponseModel.fromJson(response);
      final data = Map<String, dynamic>.from(apiResponse.data as Map? ?? {});

      return Right(CourseCatalogPageModel.fromJson(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}
