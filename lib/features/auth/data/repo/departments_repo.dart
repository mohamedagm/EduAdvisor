import 'package:dartz/dartz.dart';
import 'package:edu_advisor/core/api/api_consumer.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/errors/exceptions.dart';
import 'package:edu_advisor/core/errors/failures.dart';
import 'package:edu_advisor/features/auth/data/models/department_model.dart'; // مسار الموديل بتاعك

class DepartmentsRepo {
  final ApiConsumer _apiConsumer;

  DepartmentsRepo({required ApiConsumer apiConsumer})
    : _apiConsumer = apiConsumer;

  Future<Either<Failure, List<DepartmentModel>>> getDepartments() async {
    try {
      final response = await _apiConsumer.get(ApiEndpoints.getDepartments);

      final apiResponse = ApiResponseModel.fromJson(response);

      final List<dynamic> dataList = apiResponse.data as List? ?? [];
      final departments = dataList
          .map((json) => DepartmentModel.fromJson(json))
          .toList();

      return Right(departments);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.apiResponse));
    } catch (e) {
      return Left(ServerFailure(ApiResponseModel.message(e.toString())));
    }
  }
}
