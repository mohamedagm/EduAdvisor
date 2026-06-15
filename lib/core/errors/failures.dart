import 'package:edu_advisor/core/api/api_response_model.dart';

abstract class Failure {
  const Failure(this.apiResponse);

  final ApiResponseModel apiResponse;

  String get message => apiResponse.displayMessage;
  int get statusCode => apiResponse.statusCode;
}

class ServerFailure extends Failure {
  const ServerFailure(super.apiResponse);
}

class CacheFailure extends Failure {
  const CacheFailure(super.apiResponse);
}
