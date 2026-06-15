import 'package:dio/dio.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';

class ServerException implements Exception {
  const ServerException(this.apiResponse);

  final ApiResponseModel apiResponse;

  @override
  String toString() => apiResponse.displayMessage;
}

class CacheException implements Exception {
  const CacheException(this.message);

  final String message;

  @override
  String toString() => message;
}

void handleDioException(DioException e) {
  String messageFromStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 409:
        return 'Conflict';
      case 422:
        return 'Validation error';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      default:
        return 'Something went wrong';
    }
  }

  late final ApiResponseModel apiResponse;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      apiResponse = ApiResponseModel.message('Connection timeout');
    case DioExceptionType.badCertificate:
      apiResponse = ApiResponseModel.message('Bad certificate');
    case DioExceptionType.badResponse:
      final responseData = e.response?.data;

      if (responseData is Map<String, dynamic>) {
        apiResponse = ApiResponseModel.fromJson(
          responseData,
          fallbackStatusCode: e.response?.statusCode,
        );
        break;
      }

      apiResponse = ApiResponseModel.message(
        messageFromStatusCode(e.response?.statusCode),
        statusCode: e.response?.statusCode ?? 0,
      );
    case DioExceptionType.cancel:
      apiResponse = ApiResponseModel.message('Request was cancelled');
    case DioExceptionType.connectionError:
      apiResponse = ApiResponseModel.message('No internet connection');
    case DioExceptionType.unknown:
      apiResponse = ApiResponseModel.message('Something went wrong');
  }

  throw ServerException(apiResponse);
}
