import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/requests/models/student_history_model.dart';

class StudentHistoryRepo {
  final ApiConsumer _apiConsumer;

  StudentHistoryRepo({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  Future<Either<Failure, List<EnrollmentHistoryModel>>> getStudentHistory(
    String studentId,
  ) async {
    try {
      final response = await _apiConsumer.get(
        ApiEndpoints.getStudentHistory(studentId),
      );

      final apiResponse = ApiResponseModel.fromJson(response);

      List rawList = [];
      if (apiResponse.data is List) {
        rawList = apiResponse.data as List;
      } else if (apiResponse.data is Map) {
        final dataMap = apiResponse.data as Map<String, dynamic>? ?? {};
        rawList = dataMap['items'] as List? ?? [];
      }

      final historyList = rawList
          .map(
            (e) => EnrollmentHistoryModel.fromJson(
              Map<String, dynamic>.from(e),
            ),
          )
          .toList();

      return Right(historyList);
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