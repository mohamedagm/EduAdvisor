import 'package:dio/dio.dart';
import 'package:edu_advisor/core/api/api_constants.dart';
import 'package:edu_advisor/core/api/api_endpoints.dart';
import 'package:edu_advisor/core/api/api_response_model.dart';
import 'package:edu_advisor/core/services/token_storage_service.dart';
import 'package:flutter/foundation.dart';

class ApiInterceptor extends QueuedInterceptor {
  ApiInterceptor({
    this.language = ApiConstants.defaultLanguage,
    TokenStorageService? tokenStorageService,
    Dio? refreshDio,
  }) : _tokenStorageService = tokenStorageService ?? TokenStorageService(),
       _refreshDio = refreshDio ?? Dio(_refreshBaseOptions());

  final String language;
  final TokenStorageService _tokenStorageService;
  final Dio _refreshDio;

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
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    _logError(err);

    if (!_shouldRefresh(err)) {
      handler.next(err);
      return;
    }

    try {
      final refreshed = await _refreshToken();
      if (!refreshed) {
        await _tokenStorageService.clearTokens();
        handler.next(err);
        return;
      }

      final retryResponse = await _retryRequest(err.requestOptions);
      handler.resolve(retryResponse);
    } catch (e) {
      debugPrint('Refresh token failed: $e');
      await _tokenStorageService.clearTokens();
      handler.next(err);
    }
  }

  static BaseOptions _refreshBaseOptions() {
    return BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: ApiConstants.connectTimeout,
      receiveTimeout: ApiConstants.receiveTimeout,
      sendTimeout: ApiConstants.sendTimeout,
      headers: const {'Accept': 'application/json'},
    );
  }

  bool _shouldRefresh(DioException err) {
    return err.response?.statusCode == 401 &&
        err.requestOptions.path != ApiEndpoints.refreshToken;
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await _tokenStorageService.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    debugPrint('-------------------- TOKEN REFRESH ------------------');

    final response = await _refreshDio.post(
      ApiEndpoints.refreshToken,
      data: {'refreshToken': refreshToken},
      options: Options(headers: {'Accept-Language': language}),
    );

    final apiResponse = ApiResponseModel.fromJson(
      Map<String, dynamic>.from(response.data as Map? ?? {}),
      fallbackStatusCode: response.statusCode,
    );

    if (!apiResponse.isSuccess || apiResponse.data is! Map) {
      return false;
    }

    final data = Map<String, dynamic>.from(apiResponse.data as Map);
    final accessToken = data['token'] as String? ?? '';
    final accessTokenExpiresAt = data['tokenExpiresAt'] as String? ?? '';
    final newRefreshToken = data['refreshToken'] as String? ?? '';
    final refreshTokenExpiresAt =
        data['refreshTokenExpiresAt'] as String? ?? '';

    if (accessToken.isEmpty || newRefreshToken.isEmpty) {
      return false;
    }

    await _tokenStorageService.saveTokens(
      accessToken: accessToken,
      refreshToken: newRefreshToken,
      accessTokenExpiresAt: accessTokenExpiresAt,
      refreshTokenExpiresAt: refreshTokenExpiresAt,
    );

    debugPrint('Token refreshed successfully.');
    return true;
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final accessToken = await _tokenStorageService.getAccessToken();

    requestOptions.headers['Authorization'] = 'Bearer $accessToken';
    requestOptions.headers['Accept-Language'] = language;

    debugPrint('-------------------- API RETRY ----------------------');
    debugPrint('${requestOptions.method} ${requestOptions.uri}');

    return _refreshDio.fetch<dynamic>(
      requestOptions.copyWith(data: _cloneData(requestOptions.data)),
    );
  }

  dynamic _cloneData(dynamic data) {
    if (data is FormData) {
      return data.clone();
    }

    return data;
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
