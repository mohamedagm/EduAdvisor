import 'package:dio/dio.dart';
import 'package:edu_advisor/core/api/api_constants.dart';
import 'package:edu_advisor/core/services/token_storage_service.dart';

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

    handler.next(options);
  }
}
