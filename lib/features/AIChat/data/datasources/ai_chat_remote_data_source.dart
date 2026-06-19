import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/features/AIChat/data/models/ai_chat_request_model.dart';

abstract class AiChatRemoteDataSource {
  Future<String> askAdvisor(AiChatRequestModel request);
}

class AiChatRemoteDataSourceImpl implements AiChatRemoteDataSource {
  AiChatRemoteDataSourceImpl({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  @override
  Future<String> askAdvisor(AiChatRequestModel request) async {
    final response = await _apiConsumer.post(
      ApiEndpoints.aiAdvisorChat,
      data: request.toJson(),
    );

    return _parseAnswer(response);
  }

  String _parseAnswer(dynamic response) {
    if (response is! Map) {
      throw const ServerException(
        ApiResponseModel(
          isSuccess: false,
          message: 'Invalid advisor response',
          statusCode: 0,
        ),
      );
    }

    final responseMap = Map<String, dynamic>.from(response);
    final answer = responseMap['answer']?.toString().trim();

    if (answer == null || answer.isEmpty) {
      throw ServerException(
        ApiResponseModel.message(
          responseMap['message']?.toString() ?? 'Advisor answer was empty',
        ),
      );
    }

    return answer;
  }
}
