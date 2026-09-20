import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';

import 'package:edu_advisor/features/requests/models/student_academic_record.dart';

class AcademicRecordRepository {
  final ApiConsumer _apiConsumer;

  AcademicRecordRepository({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  /// Fetch Student Academic Record by studentId
  Future<Either<Failure, StudentAcademicRecord>> getStudentAcademicRecord(
    String studentId,
  ) async {
    try {
      final response = await _apiConsumer.get(
        ApiEndpoints.getStudentAcademicRecord(studentId),
      );

      final apiResponse = ApiResponseModel.fromJson(response);
      final studentAcademicRecord = StudentAcademicRecord.fromJson(
        Map<String, dynamic>.from(apiResponse.data),
      );

      return Right(studentAcademicRecord);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}