import 'package:dio/dio.dart';
import 'package:edu_advisor/core/errors/error_model.dart';

class ServerException implements Exception {
  const ServerException(this.errorModel);

  final ErrorModel errorModel;

  @override
  String toString() => errorModel.message;
}

class CacheException implements Exception {
  const CacheException(this.message);

  final String message;

  @override
  String toString() => message;
}

Never handleDioException(DioException error) {
  throw ServerException(_errorModelFromDioException(error));
}

ErrorModel _errorModelFromDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ErrorModel.message('Connection timeout');
    case DioExceptionType.badCertificate:
      return ErrorModel.message('Bad certificate');
    case DioExceptionType.badResponse:
      return _errorModelFromResponse(
        statusCode: error.response?.statusCode,
        response: error.response?.data,
      );
    case DioExceptionType.cancel:
      return ErrorModel.message('Request was cancelled');
    case DioExceptionType.connectionError:
      return ErrorModel.message('No internet connection');
    case DioExceptionType.unknown:
      return ErrorModel.message('Something went wrong');
  }
}

ErrorModel _errorModelFromResponse({
  required int? statusCode,
  required dynamic response,
}) {
  if (response is Map<String, dynamic>) {
    return ErrorModel.fromJson(response, fallbackStatusCode: statusCode);
  }

  return ErrorModel.message(
    _messageFromStatusCode(statusCode),
    statusCode: statusCode ?? 0,
  );
}

String _messageFromStatusCode(int? statusCode) {
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
