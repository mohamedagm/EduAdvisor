import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/services/data/models/recommendation_data_model.dart';

class RecommendationRepo {
  const RecommendationRepo({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  Future<Either<Failure, RecommendationDataModel>> getRecommendations() async {
    try {
      final response = await _apiConsumer.get(ApiEndpoints.recommendations);
      final apiResponse = ApiResponseModel.fromJson(response);
      final data = Map<String, dynamic>.from(apiResponse.data as Map? ?? {});

      return Right(RecommendationDataModel.fromJson(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}
