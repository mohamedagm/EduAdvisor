import 'package:dio/dio.dart';
import 'package:edu_advisor/core/api/api_constants.dart';
import 'package:edu_advisor/core/services/secure_storage_keys.dart';
import 'package:edu_advisor/core/services/secure_storage_service.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({
    this.language = ApiConstants.defaultLanguage,
    SecureStorageService? secureStorageService,
  }) : _secureStorageService = secureStorageService ?? SecureStorageService();

  final String language;
  final SecureStorageService _secureStorageService;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Accept-Language'] = language;

    final accessToken = await _secureStorageService.read(
      key: SecureStorageKeys.accessToken,
    );

    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }
}
