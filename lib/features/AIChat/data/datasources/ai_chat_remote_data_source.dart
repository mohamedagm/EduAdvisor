import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';

abstract class AiChatRemoteDataSource {
  Future<String> askAdvisor(String question);
}

class AiChatRemoteDataSourceImpl implements AiChatRemoteDataSource {
  AiChatRemoteDataSourceImpl({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  static const String demoStudentContext = '''
=== Student data from the system ===
Response language: English only.
Name: Mostafa
Major: Information Systems (IS)
Level: 3
Cumulative GPA: 2.85
Completed credit hours: 85 / 144
Academic probation: No
Maximum allowed registration hours: 18
Available courses: CS311, CS342, IS321
''';

  @override
  Future<String> askAdvisor(
    String question, {
    String studentContext = demoStudentContext,
    int maxTokens = 500,
  }) async {
    final response = await _apiConsumer.post(
      ApiEndpoints.aiAdvisorChat,
      data: {
        'student_context': studentContext,
        'question': '$question\n\nPlease answer in English only.',
        'max_tokens': maxTokens,
      },
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
