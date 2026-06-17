import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/AIChat/data/datasources/ai_chat_remote_data_source.dart';

class AiChatRepo {
  AiChatRepo({required AiChatRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final AiChatRemoteDataSource _remoteDataSource;

  Future<Either<Failure, String>> askAdvisor(String question) async {
    try {
      final answer = await _remoteDataSource.askAdvisor(question);
      return Right(answer);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}
