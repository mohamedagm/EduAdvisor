import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/auth/data/models/faculties_query_params.dart';
import 'package:edu_advisor/features/auth/data/models/paginated_faculties_model.dart';

class FacultiesRepo {
  final ApiConsumer _apiConsumer;

  FacultiesRepo({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  Future<Either<Failure, PaginatedFacultiesModel>> getFaculties(
    FacultiesQueryParams params, {
    String? language,
  }) async {
    try {
      final response = await _apiConsumer.get(
        ApiEndpoints.getFaculty,
        queryParameters: params.toMap(),
        headers: language != null ? {'Accept-Language': language} : null,
      );

      final apiResponse = ApiResponseModel.fromJson(response);

      final data = apiResponse.data as Map<String, dynamic>;

      return Right(PaginatedFacultiesModel.fromJson(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}
