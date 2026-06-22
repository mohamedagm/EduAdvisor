import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/advisor_nav/data/models/my_students_response_model.dart';
import 'package:edu_advisor/features/requests/models/student_requests.dart';

class AdvisorRequestRepo {
  AdvisorRequestRepo({required ApiConsumer apiConsumer})
      : _apiConsumer = apiConsumer;

  final ApiConsumer _apiConsumer;

  Future<Either<Failure, ({List<MyStudentModel> students, int totalCount})>>
  getMyStudents({String? search, int? pageNumber, int? pageSize}) async {
    try {
      final Map<String, dynamic> queryParameters = {};
      if (search != null && search.isNotEmpty) {
        queryParameters['Search'] = search;
      }
      if (pageNumber != null) queryParameters['PageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['PageSize'] = pageSize;

      final response = await _apiConsumer.get(
        ApiEndpoints.getMyStudents,
        queryParameters: queryParameters,
      );

      final apiResponse = ApiResponseModel.fromJson(response);
      final dataMap = apiResponse.data as Map<String, dynamic>? ?? {};
      final List rawList = dataMap['items'] as List? ?? [];
      final studentsList = rawList
          .map((e) => MyStudentModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      final totalCount = dataMap['totalCount'] as int? ?? studentsList.length;

      return Right((students: studentsList, totalCount: totalCount));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }

  Future<Either<Failure, ({List<StudentRequest> requests, int totalCount})>>
  getAllRequests({int? pageNumber, int? pageSize}) async {
    try {
      final Map<String, dynamic> queryParameters = {};
      if (pageNumber != null) queryParameters['PageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['PageSize'] = pageSize;

      final response = await _apiConsumer.get(
        ApiEndpoints.getPendingRequests,
        queryParameters: queryParameters,
      );

      final apiResponse = ApiResponseModel.fromJson(response);
      final dataMap = apiResponse.data as Map<String, dynamic>? ?? {};
      final List rawList = dataMap['items'] as List? ?? [];
      final requestsList = rawList
          .map((e) => StudentRequest.fromJson(Map<String, dynamic>.from(e)))
          .toList();
      final totalCount = dataMap['totalCount'] as int? ?? requestsList.length;

      return Right((requests: requestsList, totalCount: totalCount));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }

  Future<Either<Failure, ({List<StudentRequest> requests, int totalCount})>>
  getPendingRequests({int? pageNumber, int? pageSize}) =>
      getAllRequests(pageNumber: pageNumber, pageSize: pageSize);

  Future<Either<Failure, ({List<StudentRequest> requests, int totalCount})>>
  getApprovedRequests({int? pageNumber, int? pageSize}) =>
      getAllRequests(pageNumber: pageNumber, pageSize: pageSize);

  Future<Either<Failure, ({List<StudentRequest> requests, int totalCount})>>
  getRejectedRequests({int? pageNumber, int? pageSize}) =>
      getAllRequests(pageNumber: pageNumber, pageSize: pageSize);

  Future<Either<Failure, Unit>> approveRequest(String id) async {
    try {
      await _apiConsumer.patch(ApiEndpoints.approveRequest(id), data: const {});
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }

  Future<Either<Failure, Unit>> rejectRequest(
    String id, {
    String reason = "Rejected by Advisor",
  }) async {
    try {
      await _apiConsumer.patch(
        ApiEndpoints.rejectRequest(id),
        data: {"Reason": reason},
      );
      return const Right(unit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> getRegistrationRequestDetails(
    String id,
  ) async {
    try {
      final response = await _apiConsumer.get(
        '/api/v1/Advisors/RegistrationRequest/$id',
      );
      final apiResponse = ApiResponseModel.fromJson(response);
      return Right(apiResponse.data as Map<String, dynamic>? ?? {});
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}