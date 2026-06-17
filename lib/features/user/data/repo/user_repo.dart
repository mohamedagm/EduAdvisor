import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/user/data/models/current_user_model.dart';

class UserRepo {
  const UserRepo({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  Future<Either<Failure, CurrentUserModel>> getMe() async {
    try {
      final response = await _apiConsumer.get(ApiEndpoints.me);
      final apiResponse = ApiResponseModel.fromJson(response);
      final userData = Map<String, dynamic>.from(
        apiResponse.data as Map? ?? {},
      );

      return Right(CurrentUserModel.fromJson(userData));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}
