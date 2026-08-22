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
      getRegistrations({
    int? status, // 0 = Pending, 1 = Approved, 2 = Rejected
    String? studentId,
    String? semesterId,
    int? pageNumber,
    int? pageSize,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {};
      if (status != null) queryParameters['Status'] = status;
      if (studentId != null && studentId.isNotEmpty) queryParameters['StudentId'] = studentId;
      if (semesterId != null && semesterId.isNotEmpty) queryParameters['SemesterId'] = semesterId;
      if (pageNumber != null) queryParameters['PageNumber'] = pageNumber;
      if (pageSize != null) queryParameters['PageSize'] = pageSize;

      final response = await _apiConsumer.get(
        ApiEndpoints.getRegistrations, //
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
          getRegistrations(status: 0, pageNumber: pageNumber, pageSize: pageSize);

  Future<Either<Failure, ({List<StudentRequest> requests, int totalCount})>>
      getApprovedRequests({int? pageNumber, int? pageSize}) =>
          getRegistrations(status: 1, pageNumber: pageNumber, pageSize: pageSize);

  Future<Either<Failure, ({List<StudentRequest> requests, int totalCount})>>
      getRejectedRequests({int? pageNumber, int? pageSize}) =>
          getRegistrations(status: 2, pageNumber: pageNumber, pageSize: pageSize);

  
 //aprove student request

Future<Either<Failure, Unit>> approveRequest(String id) async {
  try {
    await _apiConsumer.patch(
      ApiEndpoints.approveRequest(id),
      data: const {},
    );
    return const Right(unit);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.apiResponse));
  } catch (e) {
    return Left(ServerFailure(ApiResponseModel.message(e.toString())));
  }
}

// Reject student request
Future<Either<Failure, Unit>> rejectRequest(
  String id, {
  required String reason,
}) async {
  try {
    await _apiConsumer.patch(
      ApiEndpoints.rejectRequest(id),
      data: {"reason": reason},
    );
    return const Right(unit);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.apiResponse));
  } catch (e) {
    return Left(ServerFailure(ApiResponseModel.message(e.toString())));
  }
}
/////////////
  Future<Either<Failure, StudentRequest>> getRegistrationRequestDetails(
    String id,
  ) async {
    try {
      final response = await _apiConsumer.get(
        ApiEndpoints.getRegistrationRequestDetails(id),
      );
      final apiResponse = ApiResponseModel.fromJson(response);
      final singleData = apiResponse.data as Map<String, dynamic>? ?? {};
      
      return Right(StudentRequest.fromJson(singleData));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}