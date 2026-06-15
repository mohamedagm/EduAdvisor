import 'package:dio/dio.dart';
import 'package:edu_advisor/core/api/api_constants.dart';
import 'package:edu_advisor/core/services/token_storage_service.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({
    this.language = ApiConstants.defaultLanguage,
    TokenStorageService? tokenStorageService,
  }) : _tokenStorageService = tokenStorageService ?? TokenStorageService();

  final String language;
  final TokenStorageService _tokenStorageService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept-Language'] = language;

    final accessToken = await _tokenStorageService.getAccessToken();

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    _logRequest(options);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logError(err);
    handler.next(err);
  }

  void _logRequest(RequestOptions options) {
    debugPrint('-------------------- API REQUEST --------------------');
    debugPrint('${options.method} ${options.uri}');
    debugPrint('Headers: ${_safeHeaders(options.headers)}');
    if (options.queryParameters.isNotEmpty) {
      debugPrint('Query: ${options.queryParameters}');
    }
    if (options.data != null) {
      debugPrint('Body: ${options.data}');
    }
  }

  void _logResponse(Response response) {
    debugPrint('-------------------- API RESPONSE -------------------');
    debugPrint(
      '${response.requestOptions.method} ${response.requestOptions.uri}',
    );
    debugPrint('Status: ${response.statusCode}');
    debugPrint('Data: ${response.data}');
  }

  void _logError(DioException err) {
    debugPrint('-------------------- API ERROR ----------------------');
    debugPrint('${err.requestOptions.method} ${err.requestOptions.uri}');
    debugPrint('Type: ${err.type}');
    debugPrint('Message: ${err.message}');
    debugPrint('Status: ${err.response?.statusCode}');
    debugPrint('Data: ${err.response?.data}');
  }

  Map<String, dynamic> _safeHeaders(Map<String, dynamic> headers) {
    final safeHeaders = Map<String, dynamic>.from(headers);
    if (safeHeaders.containsKey('Authorization')) {
      safeHeaders['Authorization'] = 'Bearer ***';
    }
    return safeHeaders;
  }
}
